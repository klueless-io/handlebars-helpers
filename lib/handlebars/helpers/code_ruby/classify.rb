# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Ruby code handling routines
    module CodeRuby
      # Classify: Creates a class name from a plural table name like Rails does for table names to models.
      class Classify < Handlebars::Helpers::BaseHelper
        # Parse will create a class name from a plural table name like Rails does for table names to models.
        #
        # @example
        #
        #   puts Classify.new.parse('product_categories')
        #
        #   ProductCategory
        #
        # @example
        #
        #   puts Classify.new.parse('product_category')
        #
        #   ProductCategory
        #
        # @param [String] value - name of the ruby class in plural or singular notation
        # @return [String] value converted to ruby class notation
        def parse(value)
          tokenizer.parse(value, separator: '_', forced_separator: true).classify
        end

        def handlebars_helper
          proc { |_context, value| wrapper(parse(value)) }
        end
      end
    end
  end
end
