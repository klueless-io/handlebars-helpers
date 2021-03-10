# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringFormatting
      # snake case the characters in the given 'string'.
      class Snake < Handlebars::Helpers::BaseHelper
        # Parse will snake case the characters in the given 'string'.
        #
        # @side effects
        #
        #   All text is in lower case
        #
        # @example
        #
        #   puts Snake.new.parse('the quick brown fox 99')
        #
        #   the_quick_brown_fox99
        #
        # @return [String] value converted to snake case
        def parse(value)
          tokenizer.parse(value, separator: '_', forced_separator: true)
        end
      end
    end
  end
end
