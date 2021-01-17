# frozen_string_literal: true

require 'active_support/core_ext/string'

module Handlebars
  module Helpers
    module Formatters
      # Extra general purpose string manipulation methods
      module StringExtra
        # Append the specified `suffix` to the given string.
        def append(value, suffix)
          "#{value}#{suffix}"
        end

        # Returns the plural form of the word in the string
        #
        # @example
        #
        #   puts pluralize('name')
        #
        #   names
        #
        #   puts pluralize('octopus')
        #
        #   octopi
        #
        # @return [String] .
        def pluralize(value)
          return '' if value.nil?

          value.pluralize
        end

        # The reverse of #pluralize, returns the singular form of a word in a string.
        #
        # @example
        #
        #   puts singularize('names')
        #
        #   name
        #
        #   puts singularize('octopi')
        #
        #   octopus
        #
        # @return [String] .
        def singularize(value)
          return '' if value.nil?

          value.singularize
        end
      end
    end
  end
end
