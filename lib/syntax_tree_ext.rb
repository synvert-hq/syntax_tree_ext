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
      node.set_parent_and_source(source)
      node
    end
  end

  class Node
    attr_accessor :parent, :source

    def set_parent_and_source(source)
      self.source = source
      child_nodes.each do |child_node|
        next unless child_node.is_a?(Node)

        child_node.parent = self
        child_node.set_parent_and_source(source)
      end
    end

    def siblings
      index = parent.child_nodes.index(self)
      parent.child_nodes[index + 1..]
    end

    def source
      @source[location.start_char..location.end_char]
    end
  end
end
