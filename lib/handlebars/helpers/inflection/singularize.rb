# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Inflection handling routines, eg. pluralize, singular, ordinalize
    module Inflection
      # The reverse of #pluralize, returns the singular form of a word in a string
      class Singularize < Handlebars::Helpers::BaseHelper
        # Parse will reverse of #pluralize, returns the singular form of a word in a string
        #
        # @example
        #
        #   puts Singularize.new.parse('names')
        #
        #   name
        #
        #   puts Singularize.new.parse('octopi')
        #
        #   octopus
        #
        # @return [String] plural value turned to singular value
        def parse(value)
          return '' if value.nil?

          value = value.to_s if value.is_a?(Symbol)

          value.singularize
        end
      end
    end
  end
end
