# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'
require 'handlebars/helpers/string_formatting/format_as'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringFormatting
      # Append If will append suffix to value, if value is not empty
      class AppendIf < Handlebars::Helpers::BaseHelper
        # Parse will Append If will append suffix to value, if value is not empty
        #
        # @example
        #
        #   puts AppendIf.new.parse('the quick brown', 'fox', 'dashify')
        #
        #   the-quick-brown-fox
        #
        # @param [String] value - value to add suffix too
        # @param [String] suffix - suffix to add to value
        # @param [String] formats - list of formats to apply to value, defaults to none
        # @return [String] value + suffix when value exists, otherwise ''
        def parse(value, suffix, formats)
          format_as = Handlebars::Helpers::StringFormatting::FormatAs.new
          value.present? ? "#{format_as.parse(value, formats)}#{suffix}" : ''
        end

        def handlebars_helper
          proc do |_context, value, suffix, formats|
            # Handle optional: formats
            formats = nil if formats.is_a?(V8::Object)
            parse(value, suffix, formats)
          end
        end
      end
    end
  end
end
