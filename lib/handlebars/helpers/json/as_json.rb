# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_safe_string_helper'

module Handlebars
  module Helpers
    # Miscellaneous handling routines
    module Json
      # AsJson will take handlebars object and write it out as JSON
      class AsJson < Handlebars::Helpers::BaseSafeStringHelper
        # Parse will take a ruby or handlebars object and write it out as JSON
        #
        # @example
        #
        #   puts AsJson.new.parse({david: "was here", why: ['reason1', 'reason2', 'reason3']})
        #
        #   { "david": "was here", "why": ['reason1', 'reason2', 'reason3'] }
        #
        # @param [Object] value - object to be converted to JSON string
        # @return [String] value as JSON string
        def parse(value)
          value = '' if value.nil?

          value = parse_json(value).to_json if value.is_a?(Hash) || value.is_a?(OpenStruct) || value.is_a?(V8::Object) || value.is_a?(V8::Array)

          value
        end

        def handlebars_helper
          proc do |_context, value|
            # Handle optional: value
            # value = nil if value.is_a?(V8::Object)
            wrapper(parse(value))
          end
        end
      end
    end
  end
end
