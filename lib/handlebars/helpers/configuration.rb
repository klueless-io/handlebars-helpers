# frozen_string_literal: true

require 'handlebars/helpers/string_tokenizer'

module Handlebars
  # Configuration access for Handlebars/Helpers
  module Helpers
    # Configuration access for handlebars/helpers
    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset
      @configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end

    # Configuration class
    class Configuration
      attr_accessor :tokenizer,
                    :helper_config_file,
                    :padl_count,
                    :padl_char,
                    :padr_count,
                    :padr_char
      attr_reader :string_formatter_config_file
      attr_writer :string_formatter_config

      def initialize
        @tokenizer = Handlebars::Helpers::StringTokenizer.new
        @helper_config_file = '.handlebars_helpers.json'
        @string_formatter_config_file = '.handlebars_string_formatters.json'
        @padr_count = 30
        @padr_char = ' '
        @padl_count = 30
        @padl_char = ' '
      end

      def string_formatter_config_file=(value)
        @string_formatter_config_file = value
        # updating the file will clear the config object,
        # which will be reloaded on next call to string_formatter_config
        self.string_formatter_config = nil
      end

      def string_formatter_config
        @string_formatter_config ||= build_string_formatter_config
      end

      def build_string_formatter_config
        config_content = File.read(string_formatter_config_file)
        config = JSON.parse(config_content)
        configured_formatters = config['formatters']
        configured_formatters.each_with_object({}) do |formatter, result|
          require formatter['require_path']
          helper_instance = Object.const_get(formatter['class_namespace']).new

          formatter['aliases'].each do |name|
            result[name.to_sym] = helper_instance
          end
        end
      end
    end
  end
end
