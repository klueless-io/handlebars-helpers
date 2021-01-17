# frozen_string_literal: true

require 'active_support/core_ext/string'

module Handlebars
  module Helpers
    module Formatters
      # Case modification string manipulation methods
      #
      # reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
      module StringCase
        # Set default tokenizer to use when cleaning strings for case changes
        def tokenizer=(tokenizer)
          @tokenizer = tokenizer
        end

        # Get tokenizer to use when cleaning strings for case changes.
        #
        # @default side effects
        #
        #   All text is in lower case
        #   Numbers at beginning will cling to first word
        #   Numbers at the and cling to last word
        #
        # When not configured, it will default to [Handlebars::Helpers::StringTokenizer]
        def tokenizer
          unless defined?(@tokenizer)
            require 'handlebars/helpers/string_tokenizer'
            @tokenizer = Handlebars::Helpers::StringTokenizer
          end

          @tokenizer
        end

        # convert to back slash notation
        #
        # @side effects
        #
        #   Text casing is preserved.
        #
        # @example
        #
        #   puts back_slash('the Quick brown Fox 99')
        #
        #   the\quick\brown\fox99
        #
        # @return [String] value converted forward back slash notation
        def back_slash(value)
          tokenizer.parse(value, preserve_case: true, separator: '\\')
        end

        # camel case the characters in the given 'string'.
        #
        # @example
        #
        #   puts camel('the quick brown fox 99')
        #
        #   TheQuickBrownFox99
        #
        # @return [String] value converted to camel case
        def camel(value)
          tokenizer.parse(value).underscore.camelize
        end

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
          tokenizer.parse(value).classify
        end

        # CONSTANT case the characters in the given 'string'.
        #
        # @example
        #
        #   puts camel('the quick brown fox 99')
        #
        #   THE_QUICK_BROWN_FOX99
        #
        # @return [String] value converted to constant case
        def constantize(value)
          tokenizer.parse(value, separator: '_').upcase
        end

        # convert to dash notation
        #
        # @side effects
        #
        #   All text is in lower case
        #
        # @example
        #
        #   puts dasherize('the Quick brown Fox 99')
        #
        #   the-quick-brown-fox99
        #
        # @return [String] value converted to dash notation
        def dasherize(value)
          tokenizer.parse(value)
        end

        # camel case the characters in the given 'string', with the first character as lower case.
        #
        # @example
        #
        #   puts lamel('the quick brown fox 99')
        #
        #   theQuickBrownFox99
        #
        # @return [String] value converted to lower first camel case
        def lamel(value)
          tokenizer.parse(value, separator: '_').camelize(:lower)
        end

        # snake case the characters in the given 'string'.
        #
        # @side effects
        #
        #   All text is in lower case
        #
        # @example
        #
        #   puts snake('the quick brown fox 99')
        #
        #   the_quick_brown_fox99
        #
        # @return [String] value converted to snake case
        def snake(value)
          tokenizer.parse(value, separator: '_')
        end

        # convert to slash (aka forward slash) notation
        #
        # @side effects
        #
        #   Text casing is preserved.
        #
        # @example
        #
        #   puts slash('the Quick brown Fox 99')
        #
        #   the/quick/brown/fox
        #
        # @return [String] value converted forward slash notation
        def slash(value)
          tokenizer.parse(value, preserve_case: true, separator: '/')
        end

        # Creates the name of a table like Rails does for models to table names.
        #
        # Note: This does not play well with number suffixes,
        #       I'm not sure that the edge case is really needed.
        #
        # @example
        #
        #   puts titleize('the Quick brown Fox')
        #
        #   the_quick_brown_foxes
        #
        # @return [String] value converted to title case
        def tableize(value)
          tokenizer.parse(value).tableize
        end

        # convert text to title case
        #
        # @side effects
        #
        #   Text casing set to upper case for first letters.
        #   Numbers will maintain their spacing
        #
        # @example
        #
        #   puts titleize('the Quick brown Fox 99')
        #
        #   The Quick Brown Fox 99
        #
        # @return [String] value converted to title case
        def titleize(value)
          tokenizer.parse(value,
                          separator: ' ',
                          preserve_case: true,
                          compress_prefix_numerals: false,
                          compress_suffix_numerals: false)
                   .titleize
        end

        # convert text to human case, aka sentence case.
        #
        # @side effects
        #
        #   Text casing set to upper case for first letter only.
        #   Numbers will maintain their spacing
        #
        # @example
        #
        #   puts titleize('the Quick brown Fox 99')
        #
        #   The quick brown fox 99
        #
        # @return [String] value converted to human case, aka sentence case.
        def humanize(value)
          tokenizer.parse(value,
                          separator: ' ',
                          preserve_case: true,
                          compress_prefix_numerals: false,
                          compress_suffix_numerals: false)
                   .humanize
        end
      end
    end
  end
end
