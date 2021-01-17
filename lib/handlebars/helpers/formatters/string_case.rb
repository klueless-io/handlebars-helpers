# frozen_string_literal: true

require 'active_support/core_ext/string'

module Handlebars
  module Helpers
    module Formatters
      # Case modification string manipulation methods
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

        # camel case the characters in the given 'string', with the first character as lower case.
        #
        # @example
        #
        #   puts lamel('the quick brown fox 99')
        #
        #   theQuickBrownFox99
        #
        # @return [String] value converted to camel case
        def lamel(value)
          tokenizer.parse(value).underscore.camelize(:lower)
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
          # tokenizer.parse(value).underscore.camelize(:lower)
          tokenizer.parse(value).underscore
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
        def slash(value)
          tokenizer.parse(value, preserve_case: true, separator: '/')
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
        def back_slash(value)
          tokenizer.parse(value, preserve_case: true, separator: '\\')
        end
      end
    end
  end
end
