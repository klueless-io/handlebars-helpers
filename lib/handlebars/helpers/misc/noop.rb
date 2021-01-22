# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Miscellaneous handling routines
    module Misc
      # NoOp is a wrapper for blocks, it does no additional processing.
      # It is useful for embedding blocks into the output when using raw operators {{{{noop}}}}
      class Noop < Handlebars::Helpers::BaseHelper
        # # Parse will do nothing and return.
        # # It is useful for embedding blocks into the output when using raw operators {{{{noop}}}}
        # #
        # # @example
        # #
        # #   puts Noop.new.parse()
        # #
        # # @return does nothing, but will allow inner blocks to be processed
        # def parse()
        # end

        def handlebars_helper
          proc do |context, block|
            # Handlebars::SafeString.new('<div class="bold">' + block.fn(context) + "</div>");

            block.fn(context)
          end
        end
      end
    end
  end
end
