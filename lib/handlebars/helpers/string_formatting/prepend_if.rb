# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'
require 'handlebars/helpers/string_formatting/format_as'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringFormatting
      # Append If will prepend the prefix to value, if value is not empty
      class PrependIf < Handlebars::Helpers::BaseHelper
        # Parse will Append If will prepend the prefix to value, if value is not empty
        #
        # @example
        #
        #   puts PrependIf.new.parse('turn to symbol', ':', 'snake')
        #
        #   :turn_to_symbol
        #
        # @param [String] value - value to add prepend too
        # @param [String] prefix - prefix to insert in front of value
        # @param [String] formats - list of formats to apply to value, defaults to none
        # @return [String] prefix + value when value exists, otherwise ''
        def parse(value, prefix, formats)
          format_as = Handlebars::Helpers::StringFormatting::FormatAs.new
          value.present? ? "#{prefix}#{format_as.parse(value, formats)}" : ''
        end

        def handlebars_helper
          proc do |_context, value, prefix, formats|
            # Handle optional: formats
            formats = nil if formats.is_a?(V8::Object)
            parse(value, prefix, formats)
          end
        end
      end
    end
  end
end
