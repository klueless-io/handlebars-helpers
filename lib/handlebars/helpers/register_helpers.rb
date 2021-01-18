# frozen_string_literal: true

require 'handlebars'

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
          register_all
        end
      end

      def helper(*names, &helper)
        puts "names: #{names.join(',')}"

        names.each do |name|
          handlebars.register_helper(name, &helper)
        end
      end

      def register_all
        require 'handlebars/helpers/string_case_formatting/camel'
        helper(:camel,
               :camelUpper,
               :camelU,
               &Handlebars::Helpers::StringCaseFormatting::Camel.new.handlebars_helper)
      end
    end
  end
end
