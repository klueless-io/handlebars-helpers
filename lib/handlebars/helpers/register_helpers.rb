# frozen_string_literal: true

require 'json'
require 'handlebars'
require 'handlebars/helpers/configuration'

module Handlebars
  module Helpers
    # Register helpers against handlebars context
    class RegisterHelpers
      attr_accessor :handlebars
      attr_reader :helpers

      # def initialize(handlebars = Handlebars::Context.new, &block)
      def initialize(&block)
        @handlebars = Handlebars::Context.new

        if block_given?
          block.call(self) # , handlebars)
        else
          register_from_config
        end
      end

      def helper(*names, &helper)
        names.each do |name|
          handlebars.register_helper(name, &helper)
        end
      end

      # Register from configuration file
      #
      # Sample configuration
      # "groups": [
      #   {
      #     "name": "string_case_formatting",
      #     "base_require": "handlebars/helpers/string_case_formatting",
      #     "base_namespace": "Handlebars::Helpers::StringCaseFormatting",
      #     "description": "Case modification string manipulation methods",
      #     "helpers": [
      #       {
      #         "name": "camel",
      #         "description": "convert to camel case with first word uppercase and following words uppercase",
      #         "aliases": ["camel", "camelUpper", "camelU"],
      #         "require_path": "handlebars/helpers/string_case_formatting/camel",
      #         "class_namespace": "Handlebars::Helpers::StringCaseFormatting::Camel"
      #       }
      #     ]
      #   }
      # ]
      def register_from_config
        file = File.read Handlebars::Helpers.configuration.helper_config_file
        config = JSON.parse(file)

        config['groups'].each do |group|
          group['helpers'].each do |helper_config|
            register_config_item(helper_config)
          end
        end
      end

      private

      def register_config_item(config)
        require config['require_path']

        helper_instance = Object.const_get(config['class_namespace']).new

        helper(*config['aliases'].map(&:to_sym), &helper_instance.handlebars_helper)
      end
    end
  end
end
