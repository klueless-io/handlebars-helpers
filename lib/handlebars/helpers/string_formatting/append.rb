# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/string_case_formatting/base_helper'

module Handlebars
  module Helpers
    # General purpose string manipulation helpers
    module StringFormatting
      # Append the specified `suffix` to the given string
      class Append < Handlebars::Helpers::StringCaseFormatting::BaseHelper
        # Parse will Append the specified `suffix` to the given string
        #
        # @example
        #
        #   puts Append.new.parse('name', '.html')
        #
        #   name.html
        #
        # @return [String] suffix is appended to value
        def parse(value, suffix)
          "#{value}#{suffix}"
        end

        def handlebars_helper
          proc { |_context, value, suffix| parse(value, suffix) }
        end
      end
    end
  end
end
