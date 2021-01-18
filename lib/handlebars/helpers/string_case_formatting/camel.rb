# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/string_case_formatting/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringCaseFormatting
      # camel case the characters in the given 'string'.
      class Camel < Handlebars::Helpers::StringCaseFormatting::BaseHelper
        # Parse will camel case the characters in the given 'string'.
        #
        # @example
        #
        #   puts Camel.new.parse('the quick brown fox 99')
        #
        #   TheQuickBrownFox99
        #
        # @return [String] value converted to camel case
        def parse(value)
          tokenizer.parse(value).underscore.camelize
        end
      end
    end
  end
end
