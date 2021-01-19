# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/string_case_formatting/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringCaseFormatting
      # titleize case the characters in the given 'string', aka heading case
      class Titleize < Handlebars::Helpers::StringCaseFormatting::BaseHelper
        # Parse will titleize case the characters in the given 'string', aka heading case
        #
        # @side effects
        #
        #   Text casing set to upper case for first letters.
        #   Numbers will maintain their spacing
        #
        # @example
        #
        #   puts Titleize.new.parse('the quick brown fox 99')
        #
        #   The Quick Brown Fox 99
        #
        # @return [String] value converted to titleize case
        def parse(value)
          tokenizer.parse(value,
                          separator: ' ',
                          preserve_case: true,
                          compress_prefix_numerals: false,
                          compress_suffix_numerals: false)
                   .titleize
        end
      end
    end
  end
end
