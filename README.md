# SyntaxTreeExt

[![Build Status](https://github.com/synvert-hq/syntax_tree_ext/actions/workflows/main.yml/badge.svg)](https://github.com/synvert-hq/syntax_tree_ext/actions/workflows/main.yml)
[![Gem Version](https://img.shields.io/gem/v/syntax_tree_ext.svg)](https://rubygems.org/gems/syntax_tree_ext)

It adds some helpers syntax_tree node.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add syntax_tree_ext

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install syntax_tree_ext

## Usage

```ruby
require 'syntax_tree'
require 'syntax_tree_ext'

# node is a HashLiteral or BareAssocHash node
node.foo_assoc # get the assoc node of hash foo key
node.foo_value # get the value node of the hash foo key
node.foo_source # get the source of the value node of the hash foo key
node.keys # get key nodes of the hash node
node.values # get value nodes of the hash node

# all nodes
node.to_value # get the value of the node, like `true`, `false`, `nil`, `1`, `"foo"`
node.to_source # get the source code of the node
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/synvert-hq/syntax_tree_ext.
