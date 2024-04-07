# frozen_string_literal: true

module SyntaxTree
  class << self
    alias_method :original_parse, :parse

    def parse(source)
      node = original_parse(source)
      node.set_source(source)
      node
    end
  end

  class Node
    attr_accessor :source

    def set_source(source)
      self.source = source
      self.deconstruct_keys([]).filter { |key, _value| ![:location, :comments].include?(key) }.values.each do |child_node|
        if child_node.is_a?(Array)
          child_node.each do |child_child_node|
            next unless child_child_node.is_a?(Node)

            child_child_node.set_source(source)
          end
        end

        next unless child_node.is_a?(Node)

        child_node.set_source(source)
      end
    end
  end
end
