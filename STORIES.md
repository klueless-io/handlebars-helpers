# Handlebars Helpers

> Handlebars Helpers is a library that provides <b>5</b> handlebars helpers across <b>42</b> categories, it was built to complement [cowboyd/handlebars.rb](https://github.com/cowboyd/handlebars.rb) with Ruby helpers commonly found in the Javascript community

As a Ruby Developer, I want to use HandlebarsJS with useful helpers, so that I have a rich templating experience

## Development radar

### Stories next on list

As a Documentor, I can create usage examples for this GEM, so that I can document the project

- setup rspec-usage for the project
- create templates for generating slide decks
- record videos on how to use

As a Developer, I can release a new version of the GEM, so that the updated Gem appears on rubygems and rubydoc

- gem release
- research automated solution, eg. rake
- implement the solution

As a Developer, I have flexible and modular formatters, so that I can format data into a new format

- Define formatter categories, https://github.com/helpers/handlebars-helpers has 20 categories
- Create modular formatters with tests

### Tasks next on list

add support for string_formatter usage via STRING_FORMATTER.md

add gem release rake task

add support for category and helper count to readme.md

## Stories and tasks

### Stories - completed

As a Developer, I can easily render Handlebar Templates, so that I am more efficient

- Build simplified API for rendering templates

As a Developer, I can have string case formatting helpers, so that I can generate code and documentation using handlebars

As a Developer, I can alias existing helpers, so that I have helper names that make sense to me

- Provide a flexible mechanism for template aliases

As a Developer, I can load specific groups of helpers, so that memory consumption can be minimized

- Lazy load ruby helpers on an as needed basis

### Tasks - completed

check camel P02E04 has correct formatting

- tested alpha-numeric coded value with word separation (p02_ef4 &gt; P02Ef4)
- tested alpha-numeric coded value without word separation (p02ef4 &gt; P02ef4)

add support for misc helper category

- add noop/raw helper
- add safe helper

refactor inflections namespace

- Move pluralize and singularize to inflections
- Add support for ordinalize case, eg. 1st, 2nd, 3rd, 4th
- Add support for ordinal case, eg. st, nd, rd, th

String tokenizer that formats input strings in a consistent fashion

- Setup a single opinionated string tokenizer
- Make the string tokenizer configurable so it can be replaced with a different opinionated tokenizer

Setup RubyGems and RubyDoc

- Build and deploy gem to [rubygems.org](https://rubygems.org/gems/handlebars-helpers)
- Attach documentation to [rubydoc.info](https://rubydoc.info/github/klueless-io/handlebars-helpers/master)

Setup GitHub Action (test and lint)

- Setup Rspec action
- Setup RuboCop action

Setup project management, requirement and SCRUM documents

- Setup readme file
- Setup user stories and tasks
- Setup a project backlog
- Setup an examples/usage document

Setup new Ruby GEM

- Build out a standard GEM structure
- Add automated semantic versioning
- Add Rspec unit testing framework
- Add RuboCop linting
- Add Guard for automatic watch and test
- Add GitFlow support
- Add GitHub Repository
