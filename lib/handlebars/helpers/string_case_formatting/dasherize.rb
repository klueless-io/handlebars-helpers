# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/string_case_formatting/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringCaseFormatting
      # convert to dash notation
      class Dasherize < Handlebars::Helpers::StringCaseFormatting::BaseHelper
        # Parse will convert to dash notation
        #
        # @side effects
        #
        #   All text is in lower case
        #
        # @example
        #
        #   puts Dasherize.new.parse('the quick brown fox 99')
        #
        #   the-quick-brown-fox99
        #
        # @return [String] value converted to dash notation
        def parse(value)
          tokenizer.parse(value)
        end
      end
    end
  end
end
