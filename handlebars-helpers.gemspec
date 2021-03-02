# frozen_string_literal: true

require_relative 'lib/handlebars/helpers/version'
require_relative 'lib/handlebars/helpers/statistics'

Gem::Specification.new do |spec|
  description = "Handlebars Helpers provides (#{Handlebars::Helpers::HANDLER_COUNT}) handlebars helpers across (#{Handlebars::Helpers::CATEGORY_COUNT}) categories"

  spec.required_ruby_version  = '>= 2.5'
  spec.name                   = 'handlebars-helpers'
  spec.version                = Handlebars::Helpers::VERSION
  spec.authors                = ['David Cruwys']
  spec.email                  = ['david@ideasmen.com.au']

  spec.summary                = description
  spec.description            = description
  spec.homepage               = 'http://appydave.com/gems/handlebars-helpers'
  spec.license                = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/klueless-io/handlebars-helpers'
  spec.metadata['changelog_uri'] = 'https://github.com/klueless-io/handlebars-helpers/commits/master'
  spec.metadata['documentation_uri'] = 'https://rubydoc.info/github/klueless-io/handlebars-helpers/master'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the RubyGem files that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  # spec.files.each do |file|
  #   puts file
  # end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.extra_rdoc_files = ['README.md', 'STORIES.md', 'USAGE.md']
  spec.rdoc_options    += [
    '--title', 'handlebars-helpers by appydave.com',
    '--main', 'README.md',
    '--files STORIES.MD USAGE.MD'
  ]

  # spec.add_dependency 'tty-box',         '~> 0.5.0'
  spec.add_dependency 'activesupport'   , '~> 6'
  spec.add_dependency 'handlebars'      , '~> 0.8.0'
end
