# frozen_string_literal: true

require 'active_support/core_ext/string'

module Handlebars
  module Helpers
    module Formatters
      # Extra general purpose string manipulation methods
      module StringExtra
        # Append the specified `suffix` to the given string.
        def camel(value, suffix)
          "#{value}#{suffix}"
        end
      end
    end
  end
end
