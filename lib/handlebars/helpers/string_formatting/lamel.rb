# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringFormatting
      # lamel case is the same as camel case except with the first character as lower case
      class Lamel < Handlebars::Helpers::BaseHelper
        # Parse will lamel case is the same as camel case except with the first character as lower case
        #
        # @example
        #
        #   puts Lamel.new.parse('the quick brown fox 99')
        #
        #   theQuickBrownFox99
        #
        # @return [String] value converted to lamel case
        def parse(value)
          tokenizer.parse(value, separator: '_').camelize(:lower)
        end
      end
    end
  end
end
