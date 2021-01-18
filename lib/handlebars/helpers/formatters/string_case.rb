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
      end
    end
  end
end
