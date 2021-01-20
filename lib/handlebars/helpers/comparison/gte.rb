# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # Gte: (greater than or equal to) Block helper that renders a block if `a` is **greater than** `b`. If an inverse block is specified it will be rendered when falsy.
      class Gte < Handlebars::Helpers::BaseHelper
        # Parse will Gte: (greater than or equal to) Block helper that renders a block if `a` is **greater than** `b`. If an inverse block is specified it will be rendered when falsy.
        #
        # @example
        #
        #   puts Gte.new.parse(1, 2)
        #
        #   Falsey
        #
        #   puts Gte.new.parse(1, 1)
        #
        #   Truthy
        #
        #   puts Gte.new.parse(2, 1)
        #
        #   Truthy
        #
        # @param [String] lhs - left hand side value
        # @param [String] rhs - right hand side value
        # @return [String] truthy value if left hand side GREATER THAN or EQUAL TO right hand side
        def parse(lhs, rhs)
          lhs >= rhs
        end

        def handlebars_helper
          proc { |_context, lhs, rhs| parse(lhs, rhs) }
        end
      end
    end
  end
end
