# frozen_string_literal: true

require 'handlebars/helpers/version'
require 'handlebars/helpers/template'
require 'handlebars/helpers/registration'

module Handlebars
  module Helpers
    # raise Handlebars::Helpers::Error, 'Sample message'
    class Error < StandardError; end

    # Your code goes here...
  end
end
