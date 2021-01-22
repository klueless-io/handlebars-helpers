# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Inflection handling routines, eg. pluralize, singular, ordinalize
    module Inflection
      # Returns the plural form of the word in the string
      class Pluralize < Handlebars::Helpers::BaseHelper
        # Parse will Returns the plural form of the word in the string
        #
        # @example
        #
        #   puts Pluralize.new.parse('name')
        #
        #   names
        #
        #   puts Pluralize.new.parse('octopus')
        #
        #   octopi
        #
        #
        # @return [String] value in plural form
        def parse(value)
          return '' if value.nil?

          value.pluralize
        end
      end
    end
  end
end
