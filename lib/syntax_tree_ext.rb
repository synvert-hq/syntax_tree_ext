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
    end
  end
end
