# frozen_string_literal: true

require 'handlebars/helpers/configuration'

module Handlebars
  module Helpers
    # base helper provides an interface to wrap your parsing logic
    # in a Handlebars aware context
    class BaseHelper
      # Wrap the parse method in a handlebars context
      # aware block that is used during registration
      def handlebars_helper
        proc { |_context, value| wrapper(parse(value)) }
      end

      # All child classes will generally implement this method
      def parse(value)
        value
      end

      # If you need to wrap the return value in a specific
      # Handlebars Type, eg. SafeString, then you can override
      # this method
      def wrapper(value)
        value
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
