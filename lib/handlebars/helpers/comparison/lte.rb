# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # Lte: (less than or equal to) Block helper that renders a block if `a` is **less than or equal to** `b`. If an inverse block is specified it will be rendered when falsy.
      class Lte < Handlebars::Helpers::BaseHelper
        # Parse will Lte: (less than or equal to) Block helper that renders a block if `a` is **less than or equal to** `b`. If an inverse block is specified it will be rendered when falsy.
        #
        # @example
        #
        #   puts Lte.new.parse(1, 2)
        #
        #   Truthy
        #
        #   puts Lte.new.parse(1, 1)
        #
        #   Truthy
        #
        #   puts Lte.new.parse(2, 1)
        #
        #   Falsey
        #
        # @param [String] lhs - left hand side value
        # @param [String] rhs - right hand side value
        # @return [String] truthy value if left hand side LESS THAN or EQUAL to right hand side
        def parse(lhs, rhs)
          lhs <= rhs
        end

        def handlebars_helper
          proc { |_context, lhs, rhs| parse(lhs, rhs) }
        end
      end
    end
  end
end
