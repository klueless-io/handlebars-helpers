# frozen_string_literal: true

require 'handlebars/helpers/version'
require 'handlebars/helpers/template'
require 'handlebars/helpers/register_helpers'

module Handlebars
  module Helpers
    # raise Handlebars::Helpers::Error, 'Sample message'
    class Error < StandardError; end

    # Your code goes here...
  end
end
