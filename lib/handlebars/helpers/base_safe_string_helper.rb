# frozen_string_literal: true

require 'handlebars/safe_string'
require 'handlebars/helpers/configuration'
require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # base safe string helper provides will return a Handlebars::SafeString
    # which allows characters like < > " to be rendered as is
    class BaseSafeStringHelper < BaseHelper
      def wrapper(value)
        Handlebars::SafeString.new(value)
      end
    end
  end
end
