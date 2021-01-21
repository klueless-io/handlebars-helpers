# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'
require 'handlebars/helpers/string_formatting/format_as'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringFormatting
      # Surround will surround a value with prefix and suffix, an empty value is considered valid data
      class Surround < Handlebars::Helpers::BaseHelper
        # Parse will surround a value with prefix and suffix, an empty value is considered valid data
        #
        # @example
        #
        #   puts Surround.new.parse('product category', '"', '"', 'titleize')
        #
        #   "Product Category"
        #
        # @example
        #
        #   puts Surround.new.parse(nil, '"', '"', 'titleize')
        #
        #   ""
        #
        # @param [String] value - value to surround
        # @param [String] prefix - prefix to insert in front of value
        # @param [String] suffix - suffix to append to value
        # @param [String] formats - list of formats to apply to value, defaults to none
        # @return [String] prefix + value + suffix
        def parse(value, prefix, suffix, formats)
          format_as = Handlebars::Helpers::StringFormatting::FormatAs.new
          "#{prefix}#{format_as.parse(value, formats)}#{suffix}"
        end

        def handlebars_helper
          proc do |_context, value, prefix, suffix, formats|
            # Handle optional: formats
            formats = nil if formats.is_a?(V8::Object)
            Handlebars::SafeString.new(parse(value, prefix, suffix, formats))
          end
        end
      end
    end
  end
end
