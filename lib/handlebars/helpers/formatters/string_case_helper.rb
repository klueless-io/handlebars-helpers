# frozen_string_literal: true

require 'handlebars/helpers/formatters/string_case'

module Handlebars
  module Helpers
    module Formatters
      # Case modification string manipulation methods
      #
      # reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
      class StringCaseHelper
        include StringCase

        def back_slash_helper; end

        def camel_helper
          proc { |_context, value| camel(value) }
        end

        def constantize_helper; end

        def dasherize_helper; end

        def lamel_helper; end

        def snake_helper; end

        def slash_helper; end

        def titleize_helper; end

        def humanize_helper; end
      end
    end
  end
end
