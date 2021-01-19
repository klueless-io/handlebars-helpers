# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/string_case_formatting/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringCaseFormatting
      # slash case the characters in the given 'string'.
      class Slash < Handlebars::Helpers::StringCaseFormatting::BaseHelper
        # Parse will slash case the characters in the given 'string'.
        #
        # @side effects
        #
        #   Text casing is preserved.
        #
        # @example
        #
        #   puts Slash.new.parse('the Quick brown Fox 99')
        #
        #   the/Quick/brown/Fox99
        #
        # @return [String] value converted to slash notation
        def parse(value)
          tokenizer.parse(value, preserve_case: true, separator: '/')
        end
      end
    end
  end
end
