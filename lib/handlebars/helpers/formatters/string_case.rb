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
        #   puts camel('the quick brown fox')
        #
        #   TheQuickBrownFox
        def camel(value)
          tokenizer.parse(value).underscore.camelize
        end

        # camel case the characters in the given 'string', with the first character as lower case.
        #
        # @example
        #
        #   puts lamel('the quick brown fox')
        #
        #   theQuickBrownFox
        def lamel(value)
          tokenizer.parse(value).underscore.camelize(:lower)
        end

        # snake case the characters in the given 'string'.
        #
        # @example
        #
        #   puts snake('the quick brown fox')
        #
        #   the_quick_brown_fox
        def snake(value)
          # tokenizer.parse(value).underscore.camelize(:lower)
          tokenizer.parse(value).underscore
        end
      end
    end
  end
end
