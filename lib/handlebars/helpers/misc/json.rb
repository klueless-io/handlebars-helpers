# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_safe_string_helper'

module Handlebars
  module Helpers
    # Miscellaneous handling routines
    module Misc
      # Json will take handlebars object and write it out as JSON
      class Json < Handlebars::Helpers::BaseSafeStringHelper
        # Parse will take a ruby or handlebars object and write it out as JSON
        #
        # @example
        #
        #   puts Json.new.parse({david: "was here", why: ['reason1', 'reason2', 'reason3']})
        #
        #   { "david": "was here" }
        #
        # @param [Object] value - object to be converted to JSON string
        # @return [String] value as JSON string
        def parse(value)
          value = '' if value.nil?

          value = parse_json(value).to_json if value.is_a?(Hash) || value.is_a?(OpenStruct) || value.is_a?(V8::Object) || value.is_a?(V8::Array)

          value
        end

        def handlebars_helper
          proc do |_context, value|
            # Handle optional: value
            # value = nil if value.is_a?(V8::Object)
            wrapper(parse(value))
          end
        end

        private

        # This needs to be in a data_helper
        # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/HashEachMethods
        def parse_json(value, hash = {})
          return value.map { |item| parse_json(item) } if value.is_a?(V8::Array)

          return struct_to_hash(value) if value.is_a?(OpenStruct)

          return value unless value.is_a?(V8::Object)

          value.keys.each do |key|
            hash[key] = case value[key]
                        when V8::Object
                          parse_json(value[key])
                        when V8::Array
                          value[key].map do |item|
                            case item
                            when V8::Object, V8::Array
                              parse_json(item)
                            when String
                              item
                            else
                              item.values
                            end
                          end
                        else
                          value[key]
                        end
          end

          hash
        end
        # rubocop:enable Metrics/PerceivedComplexity, Style/HashEachMethods

        # Needs to move into a GEM and make sure I have consistency
        def struct_to_hash(data)
          # No test yet
          if data.is_a?(Array)
            return data.map { |v| v.is_a?(OpenStruct) ? struct_to_hash(v) : v }
          end

          data.each_pair.with_object({}) do |(key, value), hash|
            case value
            when OpenStruct
              hash[key] = struct_to_hash(value)
            when Array
              # No test yet
              values = value.map { |v| v.is_a?(OpenStruct) ? struct_to_hash(v) : v }
              hash[key] = values
            else
              hash[key] = value
            end
          end
        end
        # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity
      end
    end
  end
end
