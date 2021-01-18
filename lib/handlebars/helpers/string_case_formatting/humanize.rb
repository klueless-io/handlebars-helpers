# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/string_case_formatting/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringCaseFormatting
      # humanize wil convert text to human case, aka sentence case
      class Humanize < Handlebars::Helpers::StringCaseFormatting::BaseHelper
        # Parse will humanize wil convert text to human case, aka sentence case
        #
        # @side effects
        #
        #   Text casing set to upper case for first letter only.
        #   Numbers will maintain their spacing
        #
        # @example
        #
        #   puts Humanize.new.parse('the quick brown fox 99')
        #
        #   The quick brown fox 99
        #
        # @return [String] value converted to sentence case
        def parse(value)
          tokenizer.parse(value,
                          separator: ' ',
                          preserve_case: true,
                          compress_prefix_numerals: false,
                          compress_suffix_numerals: false)
                   .humanize
        end
      end
    end
  end
end
