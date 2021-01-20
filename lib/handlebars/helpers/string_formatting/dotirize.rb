# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/string_formatting/base_helper'

module Handlebars
  module Helpers
    # String manipulation methods for case formatting
    module StringFormatting
      # convert to dot notation
      class Dotirize < Handlebars::Helpers::StringFormatting::BaseHelper
        # Parse will convert to dot notation
        #
        # @side effects
        #
        #   All text is in lower case
        #
        # @example
        #
        #   puts Dotirize.new.parse('the quick brown fox 99')
        #
        #   the.quick.brown.fox99
        #
        # @return [String] value converted to dot notation
        def parse(value)
          tokenizer.parse(value, separator: '.')
        end
      end
    end
  end
end
