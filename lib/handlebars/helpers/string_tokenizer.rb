# frozen_string_literal: true

require 'active_support/core_ext/string'

module Handlebars
  module Helpers
    # String tokenizer will clean up a string so that all sorts of formatted strings can be
    # represented in a consistent fashion
    class StringTokenizer
      # Tokenize string
      def self.parse(value)
        return '' if value.nil?

        value.parameterize#(separator: ' ')
      end
    end
  end
end
