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
