# SyntaxTreeExt

It adds `parent_node` and `source` methods to the `ParserTree::Node`.

It also adds some helpers

```ruby
# node is a HashLiteral node
node.foo_assoc # get the assoc node of hash foo key
node.foo_value # get the value node of the hash foo key
node.foo_source # get the source of the value node of the hash foo key
```

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add syntax_tree_ext

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install syntax_tree_ext

## Usage

```ruby
require 'syntax_tree'
require 'syntax_tree_ext'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/synvert-hq/syntax_tree_ext.
