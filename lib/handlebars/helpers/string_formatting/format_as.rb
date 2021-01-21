# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringFormatting
      # Format As: Chain a list of string formatters to run sequentially
      class FormatAs < Handlebars::Helpers::BaseHelper
        # Parse will execute a chain of string formatters and run them sequentially
        #
        # @example
        #
        #   puts FormatAs.new.parse('the quick brown fox', 'pluralize,dashify')
        #
        #   the-quick-brown-foxes
        #
        # @param [String] value - value to format
        # @param [String] formats - comma delimited list of formats
        # @return [String] returns a value that has been processed by multiple formatters
        def parse(value, formats)
          return '' if value.nil?
          return value if formats.nil? || formats.empty?

          formats = formats.split(',') if formats.is_a?(String)
          formats = formats.map(&:to_sym)
          formats.each do |format|
            value = format_value(value, format)
          end
          value
        end

        def handlebars_helper
          proc { |_context, value, formats| parse(value, formats) }
        end

        private

        def format_value(value, format)
          return value if format == :none

          formatter = Handlebars::Helpers.configuration.string_formatter_config[format]
          unless formatter
            puts 'Logger not found: format'
            return value
          end

          formatter.parse(value)
        end
      end
    end
  end
end
