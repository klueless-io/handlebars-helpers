# frozen_string_literal: true

require 'active_support/core_ext/string'

module Handlebars
  module Helpers
    module Formatters
      # Extra general ruby code generation formatters
      #
      # reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
      module CodeRuby
        # Creates a class name from a plural table name like Rails does for table names to models.
        #
        # Note: This does not play well with number suffixes,
        #       I'm not sure that the edge case is really needed.
        #
        # @example
        #
        #   puts classify('the_quick_brown_foxes')
        #
        #   TheQuickBrownFox
        #
        # @return [String] value converted to ruby class notation
        def classify(value)
          return '' if value.nil?

          value.classify
        end

        # Removes the module part from the expression in the string.
        #
        #   demodulize('ActiveSupport::Inflector::Inflections') # => "Inflections"
        #   demodulize('Inflections')                           # => "Inflections"
        #   demodulize('::Inflections')                         # => "Inflections"
        #   demodulize('')                                      # => ""
        def demodulize(value)
          return '' if value.nil?

          value.demodulize
        end

        # Removes the rightmost segment from the constant expression in the string.
        #
        #   deconstantize('Net::HTTP')   # => "Net"
        #   deconstantize('::Net::HTTP') # => "::Net"
        #   deconstantize('String')      # => ""
        #   deconstantize('::String')    # => ""
        #   deconstantize('')            # => ""
        def deconstantize(value)
          return '' if value.nil?

          value.deconstantize
        end

        # Creates a foreign key name from a class name.
        # +separate_class_name_and_id_with_underscore+ sets whether
        # the method should put '_' between the name and 'id'.
        #
        #   foreign_key('Message')                              # => "message_id"
        #   foreign_key('Message', class_id_underscored: false) # => "messageid"
        #   foreign_key('Admin::Post')                          # => "post_id"
        def foreign_key(class_name, class_id_underscored: true)
          class_name.foreign_key(class_id_underscored)
        end

        # Creates the name of a table like Rails does for models to table names.
        #
        # @example
        #
        #   puts titleize('the Quick brown Fox')
        #
        #   the_quick_brown_foxes
        #
        # @return [String] value converted to title case
        def tableize(value)
          return '' if value.nil?

          value.tableize
        end
      end
    end
  end
end
