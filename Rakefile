# frozen_string_literal: true

GEM_NAME = 'handlebars-helpers'

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'handlebars/helpers/version'

RSpec::Core::RakeTask.new(:spec)

require 'rake/extensiontask'

desc 'Compile all the extensions'
task build: :compile

Rake::ExtensionTask.new('handlebars_helpers') do |ext|
  ext.lib_dir = 'lib/handlebars_helpers'
end

desc 'Publish the gem to RubyGems.org'
task :publish do
  system 'gem build'
  system "gem push #{GEM_NAME}-#{Handlebars::Helpers::VERSION}.gem"
end

desc 'Remove old *.gem files'
task :clean do
  system 'rm *.gem'
end

task default: %i[clobber compile spec]
