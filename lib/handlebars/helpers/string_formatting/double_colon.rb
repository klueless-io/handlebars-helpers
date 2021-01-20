# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/string_formatting/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringFormatting
      # double_colon notation for the characters in the given 'string'. aka ruby namespace
      class DoubleColon < Handlebars::Helpers::StringFormatting::BaseHelper
        # Parse will double_colon notation for the characters in the given 'string'. aka ruby namespace
        #
        # @side effects
        #
        #   Text casing is preserved.
        #
        # @example
        #
        #   puts DoubleColon.new.parse('the quick brown fox 99')
        #
        #   The::Quick::Brown::Fox99
        #
        # @return [String] value converted to double_colon notation
        def parse(value)
          tokenizer.parse(value, preserve_case: true, separator: '::')
        end
      end
    end
  end
end
