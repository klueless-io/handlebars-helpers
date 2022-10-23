# frozen_string_literal: true

require 'handlebars/helpers/version'
require 'handlebars/helpers/template'
require 'handlebars/helpers/register_helpers'
# ruby docs is not showing all classes because
# this gem dynamically loads the classes for performance reasons

module Handlebars
  module Helpers
    # raise Handlebars::Helpers::Error, 'Sample message'
    class Error < StandardError; end

    # Your code goes here...
  end
end

if ENV.fetch('KLUE_DEBUG', 'false').downcase == 'true'
  namespace = 'Handlebars::Helpers::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('handlebars/helpers/version') }
  version   = Handlebars::Helpers::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
