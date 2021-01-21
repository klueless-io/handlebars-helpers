# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringFormatting
      # CONSTANT case the characters in the given 'string'.
      class Constantize < Handlebars::Helpers::BaseHelper
        # Parse will CONSTANT case the characters in the given 'string'.
        #
        # @example
        #
        #   puts Constantize.new.parse('the quick brown fox 99')
        #
        #   THE_QUICK_BROWN_FOX99
        #
        # @return [String] value converted to constant case
        def parse(value)
          tokenizer.parse(value, separator: '_').upcase
        end
      end
    end
  end
end
