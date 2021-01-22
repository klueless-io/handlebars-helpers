# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
# require 'active_support/inflector/inflections'
require 'active_support/core_ext/integer/inflections'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Inflection handling routines, eg. pluralize, singular, ordinalize
    module Inflection
      # Ordinalize: Turns a number into an ordinal string used to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th.
      class Ordinalize < Handlebars::Helpers::BaseHelper
        # Parse will Ordinalize: Turns a number into an ordinal string used to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th.
        #
        # @example
        #
        #   puts Ordinalize.new.parse('1')
        #
        #   1st
        #
        # @example
        #
        #   puts Ordinalize.new.parse('2')
        #
        #   2nd
        #
        # @example
        #
        #   puts Ordinalize.new.parse('3')
        #
        #   3rd
        #
        # @example
        #
        #   puts Ordinalize.new.parse('4')
        #
        #   4th
        #
        # @param [String] value - numeric value
        # @return [String] number value turned to 1st, 2nd, 3rd, 4th etc.
        def parse(value)
          return '' if value.nil?

          value = value.to_i if value.is_a? String

          value.ordinalize
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
