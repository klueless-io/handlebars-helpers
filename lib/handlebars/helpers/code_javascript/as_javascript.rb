# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_safe_string_helper'

module Handlebars
  module Helpers
    # Miscellaneous handling routines
    module CodeJavascript
      # take ruby object and write it out as Javascript notation
      class AsJavascript < Handlebars::Helpers::BaseSafeStringHelper
        # Parse will take ruby object and write it out as Javascript notation
        #
        # @example
        #
        #   puts AsJavascript.new.parse({david: "was here", why: ['reason1', 'reason2', 'reason3']})
        #
        #   { david: "was here", why: ['reason1', 'reason2', 'reason3'] }
        #
        # @param [Object] value - object to be converted to Javascript notation string
        # @return [String] value as Javascript string
        def parse(value, format)
          return '' if value.nil?

          format = :include_root_brace if format.nil?

          javascript = case value
                       when Hash
                         hash_to_javascript(value)
                       when OpenStruct, V8::Object, V8::Array
                         hash_to_javascript(parse_json(value))
                       end

          javascript = remove_root_brace(javascript) if format == :exclude_root
          javascript
        end

        def handlebars_helper
          proc do |_context, value, format|
            # Handle optional: format
            format = nil if format.is_a?(V8::Object)
            format = format.to_sym if format.is_a?(String)

            wrapper(parse(value, format))
          end
        end

        # Convert ruby hash to javascript notation
        #
        # convert
        #   { "david": "cruwys" }
        # to
        #   { david: "cruwys" }
        def hash_to_javascript(value)
          javascript = JSON.pretty_generate(value)

          rex = /"(?<name>\w*)":/

          javascript.gsub(rex) do |_|
            "#{$LAST_MATCH_INFO['name']}:"
          end
        end

        def remove_root_brace(javascript)
          javascript.sub('{', '').tap { |s| s.slice!(s.rindex('}')) }.strip
        end
      end
    end
  end
end
