# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Ruby code handling routines
    module CodeRuby
      # Deconstantize: Removes the rightmost segment from the constant expression in the string.
      class Deconstantize < Handlebars::Helpers::BaseHelper
        # Parse will deconstantize, remove the rightmost segment from the constant expression in the string.
        #
        # @example
        #
        #   puts Deconstantize.new.parse('Net::HTTP')
        #
        #   Net
        #
        #   puts Deconstantize.new.parse('::Net::HTTP')
        #
        #   ::Net
        #
        #   puts Deconstantize.new.parse('String')
        #
        #   ""
        #
        #   puts Deconstantize.new.parse('::String')
        #
        #   ""
        #
        # @param [String] value - name of the ruby constant expression
        # @return [String] return constant without rightmost segment
        def parse(value)
          return '' if value.nil?

          value.deconstantize
        end

        def handlebars_helper
          proc { |_context, value| parse(value) }
        end
      end
    end
  end
end
