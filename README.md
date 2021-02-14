# Handlebars Helpers

> Handlebars Helpers is a library that provides <b>$HELPER_COUNT$</b> handlebars helpers across <b>$HELPER_CATEGORY_COUNT$</b> categories, it was built to complement [cowboyd/handlebars.rb](https://github.com/cowboyd/handlebars.rb) with Ruby helpers commonly found in the Javascript community

This GEM is inspired by the Javascript Library [handlebars-helpers](https://github.com/helpers/handlebars-helpers).

I am following a lot of the categories found there, but this GEM is not a one for one match to the existing JS library as I feel it is a bit dated and could use some new helpers and categories may be relevant today.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'handlebars-helpers'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install handlebars-helpers
```

## Stories

### Main Story

As a Ruby Developer, I want to use HandlebarsJS with useful helpers, so that I have a rich templating experience

See all [stories](./STORIES.md)

## Usage

See all [usage examples](./USAGE.md)

### Basic Example

#### Basic example

Description for a basic example to be featured in the main README.MD file

```ruby
class SomeRuby; end
```

## Development

Checkout the repo

```bash
git clone klueless-io/handlebars-helpers
```

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

```bash
bin/console

Handlebars::Helpers::Template.render('{{camel .}}', 'david was here')
# => "DavidWasHere"
Handlebars::Helpers::Template.render('{{dasherize .}}', 'david was here')
# => "david-was-here"
```

`handlebars-helpers` is setup with Guard, run `guard`, this will watch development file changes and run tests automatically, if successful, it will then run rubocop for style quality.

To release a new version, update the version number in `version.rb`, build the gem and push the `.gem` file to [rubygems.org](https://rubygems.org).

```bash
gem build
gem push rspec-usecases-?.?.??.gem
# or push the latest gem
ls *.gem | sort -r | head -1 | xargs gem push
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/klueless-io/handlebars-helpers. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Handlebars Helpers project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/klueless-io/handlebars-helpers/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) David Cruwys. See [MIT License](LICENSE.txt) for further details.
