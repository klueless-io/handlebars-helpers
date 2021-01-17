# frozen_string_literal: true

require 'handlebars'

module Handlebars
  module Helpers
    # Register handlebars helpers
    class Registration
      def self.register(context, &block)
        # Need to delegate this to configuration block
      end
    end
  end
end
