# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Ruby code handling routines
    module CodeRuby
      # Foreign Key: Creates a foreign key name from a class name
      # +separate_class_name_and_id_with_underscore+ sets whether
      # the method should put '_' between the name and 'id'.
      class ForeignKey < Handlebars::Helpers::BaseHelper
        # Parse will Creates a foreign key name from a class name
        #
        # @example
        #
        #   puts ForeignKey.new.parse('Message')
        #
        #   message_id
        #
        # @example
        #
        #   puts ForeignKey.new.parse('Message', class_id_underscored: false)
        #
        #   messageid
        #
        # @example
        #
        #   puts ForeignKey.new.parse('Admin::Post')
        #
        #   post_id
        #
        # @param [String] class_name - name of class
        # @param [Boolean] class_id_underscored: - optional named value (defaults to true) - is the class and ID to be separated by underscore?
        # @return [String] value converted to separate_class_name_and_id_with_underscore
        def parse(class_name, class_id_underscored: true)
          class_name.foreign_key(class_id_underscored)
        end

        def handlebars_helper
          proc { |_context, class_name, class_id_underscored| wrapper(parse(class_name, class_id_underscored: class_id_underscored)) }
        end
      end
    end
  end
end
