# frozen_string_literal: true

require 'handlebars/helpers/base_helper'
require 'handlebars/helpers/configuration'

module Handlebars
  module Helpers
    module StringCaseFormatting
      # camel case the characters in the given 'string'.
      class BaseHelper < Handlebars::Helpers::BaseHelper
        # String tokenizer will clean up a string so that
        # all sorts of case formatted strings can be
        # represented in a consistent fashion
        def tokenizer
          Handlebars::Helpers.configuration.tokenizer
        end
      end
    end
  end
end
