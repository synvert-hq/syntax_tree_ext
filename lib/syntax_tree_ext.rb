# frozen_string_literal: true

require_relative "syntax_tree_ext/version"

require 'syntax_tree'

module SyntaxTreeExt
  class Error < StandardError; end
  # Your code goes here...
end

module SyntaxTree
  class Parser
    alias_method :original_parse, :parse

    def parse
      node = original_parse
      node.set_parent_node_and_source(source)
      node
    end
  end

  class Node
    attr_accessor :parent_node, :source

    def set_parent_node_and_source(source)
      self.source = source
      child_nodes.each do |child_node|
        next unless child_node.is_a?(Node)

        child_node.parent_node = self
        child_node.set_parent_node_and_source(source)
      end
    end

    def siblings
      index = parent_node.child_nodes.index(self)
      parent_node.child_nodes[index + 1...]
    end

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
      when Label, TStringContent
        value
      else
        self
      end
    end

    def to_source
      source[location.start_char...location.end_char]
    end

    # Respond key value and source for hash node
    def method_missing(method_name, *args, &block)
      return super unless respond_to_assocs?

      if method_name.to_s.end_with?('_value')
        key = method_name.to_s[0..-7]
        return assocs.find { |assoc| assoc_key_equal?(assoc, key) }&.value
      end
      if method_name.to_s.end_with?('_source')
        key = method_name.to_s[0..-8]
        return assocs.find { |assoc| assoc_key_equal?(assoc, key) }&.value&.to_source || ''
      end

      super
    end

    def respond_to_missing?(method_name, *args)
      return super unless respond_to_assocs?

      if method_name.to_s.end_with?('_value')
        key = method_name[0..-7]
        return !!assocs.find { |assoc| assoc_key_equal?(assoc, key) }
      end
      if method_name.to_s.end_with?('_source')
        key = method_name.to_s[0..-8]
        return !!assocs.find { |assoc| assoc_key_equal?(assoc, key) }
      end

      super
    end

    private

    def respond_to_assocs?
      is_a?(HashLiteral) || is_a?(BareAssocHash)
    end

    def assoc_key_equal?(assoc, key)
      assoc_key = assoc.key.to_value.to_s
      assoc_key.end_with?(':') ? assoc_key == "#{key}:" : assoc_key == key
    end
  end
end
