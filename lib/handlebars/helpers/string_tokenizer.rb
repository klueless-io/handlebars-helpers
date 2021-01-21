# frozen_string_literal: true

require 'active_support/core_ext/string'

module Handlebars
  module Helpers
    # String tokenizer will clean up a string so that all sorts of formatted strings can be
    # represented in a consistent fashion
    class StringTokenizer
      # Tokenize string
      # rubocop:disable Metrics/ParameterLists
      def parse(value,
                preserve_case: false,
                compress_prefix_numerals: true,
                compress_suffix_numerals: true,
                separator: '-',
                forced_separator: false)
        return '' if value.nil?

        # Insert space before any lowercaseUppercase
        value = value.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')

        # make sure that any numbers followed by space and then some text has the white space removed
        value = value.gsub(/^(\d*)(\s*)/, '\1') if compress_prefix_numerals

        # Technique1: make sure that trailing space followed by number is compressed
        # NOTE: named groups don't seem to work with \1, \2 etc.
        # ex = /(?<space>[\s]*)(?<number>[\d]*)$/
        # value  =value.sub(ex) { |_| Regexp.last_match[:number] }

        # Technique2: make sure that trailing space followed by number is compressed
        value = value.gsub(/(\s*)(\d*)$/, '\2') if compress_suffix_numerals

        value = value.parameterize(preserve_case: preserve_case, separator: separator) # (separator: ' ')

        value = value.gsub(/[-_]/, separator) if forced_separator

        value
      end
      # rubocop:enable Metrics/ParameterLists
    end
  end
end
