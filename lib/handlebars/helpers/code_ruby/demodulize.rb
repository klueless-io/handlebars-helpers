# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Ruby code handling routines
    module CodeRuby
      # Demodulize: Removes the module part from the expression in the string.
      class Demodulize < Handlebars::Helpers::BaseHelper
        # Parse will demodulize, aka remove the module part from the expression in the string.
        #
        # @example
        #
        #   puts Demodulize.new.parse('ActiveSupport::Inflector::Inflections')
        #
        #   Inflections
        #
        # @example
        #   demodulize('ActiveSupport::Inflector::Inflections') # => "Inflections"
        #   demodulize('Inflections')                           # => "Inflections"
        #   demodulize('::Inflections')                         # => "Inflections"
        #   demodulize('')                                      # => ""
        #
        #   puts Demodulize.new.parse('Inflections')
        #
        #   Inflections
        #
        # @example
        #
        #   puts Demodulize.new.parse('::Inflections')
        #
        #   Inflections
        #
        # @example
        #
        #   puts Demodulize.new.parse('')
        #
        #   ""
        #
        # @param [String] value - name of the ruby module and class name separated by ::
        # @return [String] value demodulize, aka class name without module
        def parse(value)
          return '' if value.nil?

          value.demodulize
        end

        def handlebars_helper
          proc { |_context, value| parse(value) }
        end
      end
    end
  end
end
