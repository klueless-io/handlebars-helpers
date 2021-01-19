# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require 'handlebars/helpers/base_helper'

module Handlebars
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # Or: Block helper that renders a block if **any of** the given values is truthy. If an inverse block is specified it will be rendered when falsy.
      #
      # @example
      #
      # {{#if (or section1 section2)}}
      # .. content
      # {{/if}}
      #
      # @example
      #
      # {{#if (or
      #     (eq section1 "foo")
      #     (ne section2 "bar"))}}
      # .. content
      # {{/if}}
      #
      # @example
      # {{#if (or name age)}}
      #   {{name}}-{{age}}
      # {{else}}
      #   no name or age
      # {{/if}}
      class Or < Handlebars::Helpers::BaseHelper
        # Parse will Or: Block helper that renders a block if **any of** the given values is truthy. If an inverse block is specified it will be rendered when falsy.
        #
        # @example
        #
        #   puts Or.new.parse(var1, var2)
        #
        #   truthy block
        #
        # @param left hand side value
        # @param right hand side value
        # @return [String] return block when first value is truthy
        def parse(lhs, rhs)
          # L.kv 'lhs', lhs
          # L.kv 'rhs', rhs
          lhs || rhs
        end

        # Sample handlebars registration helper
        def handlebars_helper
          proc { |_context, lhs, rhs| parse(lhs, rhs) }
        end
      end
    end
  end
end
