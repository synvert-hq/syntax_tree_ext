# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SyntaxTreeExt do
  let(:parser) {
    SyntaxTree::Parser.new(<<~EOS)
      class Synvert
        def initialize; end
        def foo; end
        def bar; end
      end
    EOS
  }
  let(:node) { parser.parse }
  let(:child_node) { node.statements.body.first.bodystmt.statements.body[1] }

  it 'gets source' do
    expect(child_node.source).to eq "def initialize; end\n"
  end

  it 'gets siblings' do
    expect(child_node.siblings.size).to eq 2
  end
end
