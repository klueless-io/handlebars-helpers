# frozen_string_literal: true

require 'handlebars'

module Handlebars
  module Helpers
    # Register handlebars helpers
    class Template
      # Render template will take the template, compile it and merge it with the data
      #
      # @param [String] template The handlebars template to render against
      # @param [Hash, Array] data The data to merge with the template
      # NOTE: I'm considering where to put the configuration block, &block)
      def self.render(template, data)
        handlebars = Handlebars::Context.new

        Handlebars::Helpers::Registration.register(handlebars)

        compiled_template = handlebars.compile(template)

        # L.ostruct data#, skip_array: true

        begin
          # REFACT: Array and Hash need to be looked at
          obj = if data.is_a?(Array)
                  process_array(data)
                else
                  process_hash(data)
                end

          compiled_template.call(obj)
        rescue StandardError => e
          puts 'Failed to process template'
          puts e.message
          # L.block 'Failed to process template', e.message
          # L.exception e
        end
      end

      def self.process_array(data)
        data.map do |item|
          if item.is_a?(String)
            item # Handle array of strings
          else
            process_hash(item)
            # o = item.to_h

            # o.keys.each do |key|
            #   o[key] = o[key].to_h if o[key].instance_of?(OpenStruct)
            # end
            # o
          end
        end
      end

      def self.process_hash(data)
        obj = data.to_h

        obj.each_key do |key|
          obj[key] = obj[key].to_h if obj[key].instance_of?(OpenStruct)
        end

        obj
      end

      private_class_method :process_array
      private_class_method :process_hash
    end
  end
end
