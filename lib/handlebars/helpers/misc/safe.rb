# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_safe_string_helper'

module Handlebars
  module Helpers
    # Miscellaneous handling routines
    module Misc
      # Safe will return the value with <> and single and double quotes left as is
      class Safe < Handlebars::Helpers::BaseSafeStringHelper
        # Parse will return the value with <> and single and double quotes left as is
        #
        # @example
        #
        #   puts Safe.new.parse('<hello>')
        #
        #   <hello>
        #
        # @param [String] value that is considered a safe string
        # @return [String] value in safe string format
        def parse(value)
          value = '' if value.nil?
          value
        end

        def handlebars_helper
          proc do |_context, value|
            wrapper(parse(value))
          end
        end
      end
    end
  end
end
