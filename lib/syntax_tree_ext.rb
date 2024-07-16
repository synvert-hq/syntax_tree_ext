# frozen_string_literal: true

require_relative "syntax_tree_ext/version"

require 'syntax_tree'
require_relative "syntax_tree_ext/source_ext"
require_relative "syntax_tree_ext/parent_node_ext"

module SyntaxTreeExt
  class Error < StandardError; end
  # Your code goes here...
end

module SyntaxTree
  module HashNodeExt
    def keys
      assocs.map(&:key)
    end

    def values
      assocs.map(&:value)
    end

    # Respond key value and source for hash node
    def method_missing(method_name, *args, &block)
      if method_name.to_s.end_with?('_assoc')
        key = method_name.to_s[0..-7]
        return assocs.find { |assoc| assoc_key_equal?(assoc, key) }
      elsif method_name.to_s.end_with?('_value')
        key = method_name.to_s[0..-7]
        return assocs.find { |assoc| assoc_key_equal?(assoc, key) }&.value
      elsif method_name.to_s.end_with?('_source')
        key = method_name.to_s[0..-8]
        return assocs.find { |assoc| assoc_key_equal?(assoc, key) }&.value&.to_source || ''
      end

      super
    end

    def respond_to_missing?(method_name, *args)
      if method_name.to_s.end_with?('_assoc')
        key = method_name[0..-7]
        return !!assocs.find { |assoc| assoc_key_equal?(assoc, key) }
      elsif method_name.to_s.end_with?('_value')
        key = method_name[0..-7]
        return !!assocs.find { |assoc| assoc_key_equal?(assoc, key) }
      elsif method_name.to_s.end_with?('_source')
        key = method_name.to_s[0..-8]
        return !!assocs.find { |assoc| assoc_key_equal?(assoc, key) }
      end

      super
    end

    private

    def assoc_key_equal?(assoc, key)
      assoc_key = assoc.key.to_value.to_s
      assoc_key.end_with?(':') ? assoc_key == "#{key}:" : assoc_key == key
    end
  end

  class HashLiteral
    include HashNodeExt
  end

  class BareAssocHash
    include HashNodeExt
  end

  class Node
    def to_value
      case self
      when SymbolLiteral
        value.value.to_sym
      when StringLiteral
        parts.map(&:to_value).join
      when FloatLiteral
        value.to_f
      when Int
        value.to_i
      when Kw
        value == 'true'
      when VarRef
        value.to_value
      when Const, Label, TStringContent, Ident
        value
      when ArrayLiteral
        contents ? contents.parts.map { |part| part.to_value } : []
      else
        self
      end
    end

    def to_source
      source[location.start_char...location.end_char]
    end
  end
end
