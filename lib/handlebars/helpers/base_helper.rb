# frozen_string_literal: true

require 'handlebars/helpers/configuration'

module Handlebars
  module Helpers
    # camel case the characters in the given 'string'.
    class BaseHelper
      # Wrap the parse method in a handlebars context
      # aware block that is used during registration
      def handlebars_helper
        proc { |_context, value| parse(value) }
      end

      # String tokenizer will clean up a string so that
      # all sorts of case formatted strings can be
      # represented in a consistent fashion
      def tokenizer
        @_tokenizer ||= Handlebars::Helpers.configuration.tokenizer
      end
    end
  end
end
