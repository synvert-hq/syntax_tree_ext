# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SyntaxTreeExt do
  def parse(code)
    SyntaxTree::Parser.new(code).parse.statements.body.first
  end

  let(:source) {<<~EOS}
      class Synvert
        def initialize; end
        def foo; end
        def bar; end
      end
    EOS

  let(:node) { SyntaxTree::Parser.new(source).parse }
  let(:child_node) { node.statements.body.first.bodystmt.statements.body[1] }

  it 'gets source' do
    expect(child_node.source).to eq source
  end

  it 'gets siblings' do
    expect(child_node.siblings.size).to eq 2
  end

  describe '#to_value' do
    it 'gets for symbol' do
      node = parse(':foo')
      expect(node.to_value).to eq :foo
    end

    it 'gets for string' do
      node = parse('"foo"')
      expect(node.to_value).to eq 'foo'
    end

    it 'gets for floast' do
      node = parse('1.1')
      expect(node.to_value).to eq 1.1
    end

    it 'gets for int' do
      node = parse('1')
      expect(node.to_value).to eq 1
    end

    it 'gets for bool' do
      node = parse('true')
      expect(node.to_value).to eq true
      node = parse('false')
      expect(node.to_value).to eq false
    end
  end

  describe '#to_source' do
    it 'gets source' do
      expect(child_node.to_source).to eq "def initialize; end"
    end
  end
end
