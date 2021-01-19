# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringCaseFormatting
      # Downcase/Lowercase all of the characters in the given string.
      class Downcase < Handlebars::Helpers::BaseHelper
        # Parse will Downcase/Lowercase all of the characters in the given string.
        #
        # @example
        #
        #   puts Downcase.new.parse('The Quick Brown Fox 99')
        #
        #   the quick brown fox 99
        #
        # @return [String] value in lowercase
        def parse(value)
          return '' if value.nil?

          value.downcase
        end
      end
    end
  end
end
