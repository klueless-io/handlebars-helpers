# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Ruby code handling routines
    module CodeRuby
      # Tableize: Creates the name of a table like Rails does when converting models to table names
      class Tableize < Handlebars::Helpers::BaseHelper
        # Parse will creates the name of a table like Rails does when converting models to table names
        #
        # @example
        #
        #   puts Tableize.new.parse('product category')
        #
        #   product_categories
        #
        # @param [String] value - name of the table
        # @return [String] value converted to table case with pluralization
        def parse(value)
          # tokenizer.parse(value, separator: '_', forced_separator: true).classify
          tokenizer.parse(value).tableize
        end

        def handlebars_helper
          proc { |_context, value| wrapper(parse(value)) }
        end
      end
    end
  end
end
