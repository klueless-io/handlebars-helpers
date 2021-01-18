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
      attr_accessor :tokenizer, :helper_config_file

      def initialize
        @tokenizer = Handlebars::Helpers::StringTokenizer.new
        @helper_config_file = '.handlebars_helpers.json'
      end
    end
  end
end
