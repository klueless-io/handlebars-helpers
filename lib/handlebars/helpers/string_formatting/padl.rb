# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringFormatting
      # Add padding to the left of the value.
      class Padl < Handlebars::Helpers::BaseHelper
        # Parse will Add padding to the left of the value.
        #
        # @example
        #
        #   puts "[#{Padl.new.parse('aaa', 10)}]"
        #
        #   [       aaa]
        #
        # @example
        #
        #   puts "[#{Padl.new.parse('aaa')}]"
        #
        #   [                           aaa]
        #
        # @example
        #
        #   puts Padl.new.parse('aaa', '10', '-')
        #
        #   -------aaa
        #
        # @param [String] value - value to apply padding to
        # @param [Integer] count - how much padding to apply. defaults to configuration.padl_count
        # @param [String] char - character to pad with. defaults to configuration.padl_char
        # @return [String] value with padding to left
        def parse(value, count, char)
          value = '' if value.nil?
          count = Handlebars::Helpers.configuration.padl_count if count.nil?
          count = count.to_i if count.is_a?(String)
          char = Handlebars::Helpers.configuration.padl_char if char.nil?
          value.rjust(count, char)
        end

        def handlebars_helper
          proc do |_context, value, count, char|
            # Handle optional: value, count and char
            value = nil if value.is_a?(V8::Object)
            count = nil if count.is_a?(V8::Object)
            char = nil if char.is_a?(V8::Object)
            parse(value, count, char)
          end
        end
      end
    end
  end
end
