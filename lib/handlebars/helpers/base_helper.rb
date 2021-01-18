# frozen_string_literal: true

require 'handlebars/helpers/configuration'

module Handlebars
  module Helpers
    # camel case the characters in the given 'string'.
    class BaseHelper
      # Wrap the parse method in a handlebars context
      # aware block that is used during registration
      def handlebars_helper
        proc { |_context, value| parse(value) }
      end
    end
  end
end
