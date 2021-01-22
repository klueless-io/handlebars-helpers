# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # Eq: Block helper that renders a block if `a` is **equal to** `b`. If an inverse block is specified it will be rendered when falsy.
      class Eq < Handlebars::Helpers::BaseHelper
        # Parse will Eq: Block helper that renders a block if `a` is **equal to** `b`. If an inverse block is specified it will be rendered when falsy.
        #
        # @example
        #
        #   puts Eq.new.parse('aaa', 'aaa')
        #
        #   Truthy
        #
        # @param [String] lhs - left hand side value
        # @param [String] rhs - right hand side value
        # @return [String] truthy value if left hand side equals right hand side
        def parse(lhs, rhs)
          lhs == rhs
        end

        def handlebars_helper
          proc { |_context, lhs, rhs| wrapper(parse(lhs, rhs)) }
        end
      end
    end
  end
end
