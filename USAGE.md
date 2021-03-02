# Handlebars Helpers

> Handlebars Helpers is a library that provides <b>44</b> handlebars helpers across <b>7</b> categories, it was built to complement [cowboyd/handlebars.rb](https://github.com/cowboyd/handlebars.rb) with Ruby helpers commonly found in the Javascript community

As a Ruby Developer, I want to use HandlebarsJS with useful helpers, so that I have a rich templating experience

## Usage

### Sample Classes

#### Simple example

Render a template value using camel case and dasherize case

```ruby
Handlebars::Helpers::Template.render('{{camel .}}', 'david was here') # => "DavidWasHere"

Handlebars::Helpers::Template.render('{{dasherize .}}', 'david was here') # => "david-was-here"
```
