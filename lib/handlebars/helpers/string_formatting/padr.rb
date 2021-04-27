# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_safe_string_helper'
require 'handlebars/helpers/configuration'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringFormatting
      # Add padding to the right of the value.
      class Padr < Handlebars::Helpers::BaseSafeStringHelper
        # Parse will Add padding to the right of the value.
        #
        # @example
        #
        #   puts "[#{Padr.new.parse('aaa', 10)}]"
        #
        #   [aaa       ]
        #
        # @example
        #
        #   puts "[#{Padr.new.parse('aaa')}]"
        #
        #   [aaa                           ]
        #
        # @example
        #
        #   puts Padr.new.parse('aaa', '10', '-')
        #
        #   aaa-------
        #
        # @param [String] value - value to apply padding to
        # @param [Integer] count - how much padding to apply. defaults to configuration.padr_count
        # @param [String] char - character to pad with. defaults to configuration.padr_char
        # @return [String] value with padding to right
        def parse(value, count = nil, char = nil)
          value = '' if value.nil?
          count = Handlebars::Helpers.configuration.padr_count if count.nil?
          count = count.to_i if count.is_a?(String)
          char = Handlebars::Helpers.configuration.padr_char if char.nil?
          value.to_s.ljust(count, char)
        end

        def handlebars_helper
          proc do |_context, value, count, char|
            # Handle optional: value, count and char
            value = nil if value.is_a?(V8::Object)
            count = nil if count.is_a?(V8::Object)
            char = nil if char.is_a?(V8::Object)
            wrapper(parse(value, count, char))
          end
        end
      end
    end
  end
end
