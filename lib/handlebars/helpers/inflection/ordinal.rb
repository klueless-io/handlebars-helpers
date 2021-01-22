# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/integer/inflections'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Inflection handling routines, eg. pluralize, singular, ordinalize
    module Inflection
      # Ordinal: The suffix that should be added to a number to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th
      class Ordinal < Handlebars::Helpers::BaseHelper
        # Parse will Ordinal: The suffix that should be added to a number to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th
        #
        # @example
        #
        #   puts Ordinal.new.parse('1')
        #
        #   st
        #
        # @example
        #
        #   puts Ordinal.new.parse('2')
        #
        #   nd
        #
        # @example
        #
        #   puts Ordinal.new.parse('3')
        #
        #   rd
        #
        # @example
        #
        #   puts Ordinal.new.parse('4')
        #
        #   th
        #
        # @param [String] value - numeric value
        # @return [String] ordinal suffix that would be required for a number
        def parse(value)
          return '' if value.nil?

          value = value.to_i if value.is_a? String

          value.ordinal
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
