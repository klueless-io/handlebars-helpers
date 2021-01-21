# frozen_string_literal: true

require 'handlebars/helpers/template'

RSpec.describe 'Handlebars::Helpers::AllHelper' do
  subject { Handlebars::Helpers::Template.render(template, data) }

  context 'String formatting and manipulation methods' do
    describe 'returns a value that has been processed by multiple formatters' do
      let(:expected) { 'the-quick-brown-foxes' }
      let(:data) do
        { value: 'the quick brown fox', format: 'pluralize,dashify' }
      end

      context 'format_as' do
        let(:template) { '{{format_as value format}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to back slash notation' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'the\quick\brown\fox' }
      context 'back_slash' do
        let(:template) { '{{back_slash .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'backward_slash' do
        let(:template) { '{{backward_slash .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'slash_backward' do
        let(:template) { '{{slash_backward .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to camel case with first word uppercase and following words uppercase' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'TheQuickBrownFox' }
      context 'camel' do
        let(:template) { '{{camel .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'camel_upper' do
        let(:template) { '{{camel_upper .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'camelUpper' do
        let(:template) { '{{camelUpper .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'camelU' do
        let(:template) { '{{camelU .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'pascalcase' do
        let(:template) { '{{pascalcase .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to constant case' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'THE_QUICK_BROWN_FOX' }
      context 'constantize' do
        let(:template) { '{{constantize .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'constant' do
        let(:template) { '{{constant .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to dash notation' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'the-quick-brown-fox' }
      context 'dasherize' do
        let(:template) { '{{dasherize .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'dashify' do
        let(:template) { '{{dashify .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'dashcase' do
        let(:template) { '{{dashcase .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'hyphenate' do
        let(:template) { '{{hyphenate .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to dash notation' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'the.quick.brown.fox' }
      context 'dotirize' do
        let(:template) { '{{dotirize .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'dotify' do
        let(:template) { '{{dotify .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'dotcase' do
        let(:template) { '{{dotcase .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'double_colon notation, similar to ruby namespace' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'the::quick::brown::fox' }
      context 'double_colon' do
        let(:template) { '{{double_colon .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert all characters to lower case' do
      let(:data) { 'THE QUICK BROWN FOX' }
      let(:expected) { 'the quick brown fox' }
      context 'downcase' do
        let(:template) { '{{downcase .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'lowercase' do
        let(:template) { '{{lowercase .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert text to human case, aka capitalize' do
      let(:data) { 'the Quick Brown Fox' }
      let(:expected) { 'The quick brown fox' }
      context 'humanize' do
        let(:template) { '{{humanize .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'capitalize' do
        let(:template) { '{{capitalize .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to lamel case with first word lowercase and following words uppercase' do
      let(:data) { 'The quick brown fox' }
      let(:expected) { 'theQuickBrownFox' }
      context 'lamel' do
        let(:template) { '{{lamel .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'camel_lower' do
        let(:template) { '{{camel_lower .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'camelLower' do
        let(:template) { '{{camelLower .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'camelL' do
        let(:template) { '{{camelL .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to plus notation' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'the+quick+brown+fox' }
      context 'pluserize' do
        let(:template) { '{{pluserize .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'plusify' do
        let(:template) { '{{plusify .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'pluscase' do
        let(:template) { '{{pluscase .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to slash notation, aka forward slash' do
      let(:data) { 'the Quick brown Fox' }
      let(:expected) { 'the/Quick/brown/Fox' }
      context 'slash' do
        let(:template) { '{{slash .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'forward_slash' do
        let(:template) { '{{forward_slash .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'slash_forward' do
        let(:template) { '{{slash_forward .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to snake notation' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'the_quick_brown_fox' }
      context 'snake' do
        let(:template) { '{{snake .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'value converted to titleize case, aka heading case' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'The Quick Brown Fox' }
      context 'titleize' do
        let(:template) { '{{titleize .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'heading' do
        let(:template) { '{{heading .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'capitalize_all' do
        let(:template) { '{{capitalize_all .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert all characters to lower case' do
      let(:data) { 'The quick brown fox' }
      let(:expected) { 'THE QUICK BROWN FOX' }
      context 'upcase' do
        let(:template) { '{{upcase .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'uppercase' do
        let(:template) { '{{uppercase .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'singular value is converted to plural form' do
      let(:data) { 'category' }
      let(:expected) { 'categories' }
      context 'pluralize' do
        let(:template) { '{{pluralize .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'plural' do
        let(:template) { '{{plural .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'plural value is converted to singular from' do
      let(:data) { 'categories' }
      let(:expected) { 'category' }
      context 'singularize' do
        let(:template) { '{{singularize .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'singular' do
        let(:template) { '{{singular .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'returns value with padding to right' do
      let(:expected) { 'pad-me....' }
      let(:data) { { value: 'pad-me', count: '10', char: '.' } }

      context 'padr' do
        let(:template) { '{{padr value count char}}' }

        it { is_expected.to eq(expected) }
      end

      context 'pad_right' do
        let(:template) { '{{pad_right value count char}}' }

        it { is_expected.to eq(expected) }
      end

      context 'ljust' do
        let(:template) { '{{ljust value count char}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'returns value with padding to left' do
      let(:expected) { '....pad-me' }
      let(:data) { { value: 'pad-me', count: '10', char: '.' } }

      context 'padl' do
        let(:template) { '{{padl value count char}}' }

        it { is_expected.to eq(expected) }
      end

      context 'pad_left' do
        let(:template) { '{{pad_left value count char}}' }

        it { is_expected.to eq(expected) }
      end

      context 'rjust' do
        let(:template) { '{{rjust value count char}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'returns value with prefix if the value is present?' do
      let(:expected) { '# product_categories' }
      let(:data) do
        { value: 'product category', prefix: '# ', formats: 'pluralize,snake' }
      end

      context 'prepend_if' do
        let(:template) { '{{prepend_if value prefix formats}}' }

        it { is_expected.to eq(expected) }
      end

      context 'prefix_if' do
        let(:template) { '{{prefix_if value prefix formats}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'returns value with suffix if the value is present?' do
      let(:expected) { 'product_categories:' }
      let(:data) do
        { value: 'product category', suffix: ':', formats: 'pluralize,snake' }
      end

      context 'append_if' do
        let(:template) { '{{append_if value suffix formats}}' }

        it { is_expected.to eq(expected) }
      end

      context 'suffix_if' do
        let(:template) { '{{suffix_if value suffix formats}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'returns value with surrounding prefix/suffix if the value is present?' do
      let(:expected) { '(product_categories)' }
      let(:data) do
        {
          value: 'product category',
          prefix: '(',
          suffix: ')',
          formats: 'pluralize,snake'
        }
      end

      context 'surround_if' do
        let(:template) { '{{surround_if value prefix suffix formats}}' }

        it { is_expected.to eq(expected) }
      end

      context 'surround_if_value' do
        let(:template) { '{{surround_if_value value prefix suffix formats}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'returns value with surrounding prefix/suffix' do
      let(:expected) { '()' }
      let(:data) { { value: nil, prefix: '(', suffix: ')', formats: nil } }

      context 'surround' do
        let(:template) { '{{surround value prefix suffix formats}}' }

        it { is_expected.to eq(expected) }
      end
    end
  end

  context 'Ruby code handling routines' do
    describe 'return class name from a plural table name like Rails does for table names to models' do
      let(:expected) { 'ProductCategory' }
      let(:data) { { table_name: 'product_categories' } }

      context 'classify' do
        let(:template) { '{{classify table_name}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'removes the module part from the expression in the string' do
      let(:expected) { 'Inflections' }
      let(:data) do
        { namespaced_class: 'ActiveSupport::Inflector::Inflections' }
      end

      context 'demodulize' do
        let(:template) { '{{demodulize namespaced_class}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'remove the rightmost segment from the constant expression in the string' do
      let(:expected) { 'Net' }
      let(:data) { { constant_expression: 'Net::HTTP' } }

      context 'deconstantize' do
        let(:template) { '{{deconstantize constant_expression}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'creates a foreign key name from a class name.' do
      let(:expected) { 'message_id' }
      let(:data) { { class_name: 'Message' } }

      context 'foreign_key' do
        let(:template) { '{{foreign_key class_name}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'creates the name of a table like Rails does when converting models to table names' do
      let(:expected) { 'product_categories' }
      let(:data) { { model_name: 'product_category' } }

      context 'tableize' do
        let(:template) { '{{tableize model_name}}' }

        it { is_expected.to eq(expected) }
      end
    end
  end

  context 'Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.' do
    describe 'return value or default value' do
      let(:expected) { 'hello world' }
      let(:data) { { p1: nil, p2: nil } }

      context 'default' do
        let(:template) { '{{default p1 p2 "hello world"}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'return block when first value is truthy' do
      let(:expected) { 'param2' }
      let(:data) { { p1: nil, p2: 'param2' } }

      context 'or' do
        let(:template) do
          '
                {{~#if (or p1 p2)~}}
                  {{p1}}{{p2}}
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end

      context 'any' do
        let(:template) do
          '
                {{~#if (any p1 p2)~}}
                  {{p1}}{{p2}}
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end
    end

    describe 'return block when first value is truthy' do
      let(:expected) { 'all params exist' }
      let(:data) { { p1: 'param1', p2: 'param2' } }

      context 'and' do
        let(:template) do
          '
                {{~#if (and p1 p2)~}}
                  all params exist
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end

      context 'all' do
        let(:template) do
          '
                {{~#if (all p1 p2)~}}
                  all params exist
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end
    end

    describe 'return block when two values are equal' do
      let(:expected) { 'params are equal' }
      let(:data) { { p1: 'david', p2: 'david' } }

      context 'eq' do
        let(:template) do
          '
                {{~#if (eq p1 p2)~}}
                params are equal
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end

      context 'equal' do
        let(:template) do
          '
                {{~#if (equal p1 p2)~}}
                params are equal
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end
    end

    describe 'return block when two values are NOT equal' do
      let(:expected) { 'params are not equal' }
      let(:data) { { p1: 'aaa', p2: 'bbb' } }

      context 'ne' do
        let(:template) do
          '
                {{~#if (ne p1 p2)~}}
                params are not equal
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end

      context 'not_equal' do
        let(:template) do
          '
                {{~#if (not_equal p1 p2)~}}
                params are not equal
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end
    end

    describe 'return block when first parameter is less than second paramater' do
      let(:expected) { '1 is less than 2' }
      let(:data) { { p1: '1', p2: '2' } }

      context 'lt' do
        let(:template) do
          '
                {{~#if (lt p1 p2)~}}
                1 is less than 2
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end

      context 'less_than' do
        let(:template) do
          '
                {{~#if (less_than p1 p2)~}}
                1 is less than 2
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end
    end

    describe 'return block when first parameter is less than or equal to second paramater' do
      let(:expected) { '1 is less than or equal 1' }
      let(:data) { { p1: '1', p2: '1' } }

      context 'lte' do
        let(:template) do
          '
                {{~#if (lte p1 p2)~}}
                1 is less than or equal 1
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end

      context 'less_than_or_equal_to' do
        let(:template) do
          '
                {{~#if (less_than_or_equal_to p1 p2)~}}
                1 is less than or equal 1
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end
    end

    describe 'return block when first parameter is greater than second paramater' do
      let(:expected) { '2 is greater than 1' }
      let(:data) { { p1: '2', p2: '1' } }

      context 'gt' do
        let(:template) do
          '
                {{~#if (gt p1 p2)~}}
                2 is greater than 1
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end

      context 'greater_than' do
        let(:template) do
          '
                {{~#if (greater_than p1 p2)~}}
                2 is greater than 1
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end
    end

    describe 'return block when first parameter is greater than or equal to second paramater' do
      let(:expected) { '1 is greater than or equal 1' }
      let(:data) { { p1: '1', p2: '1' } }

      context 'gte' do
        let(:template) do
          '
                {{~#if (gte p1 p2)~}}
                1 is greater than or equal 1
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end

      context 'greater_than_or_equal_to' do
        let(:template) do
          '
                {{~#if (greater_than_or_equal_to p1 p2)~}}
                1 is greater than or equal 1
                {{~/if~}}
                '
        end

        it { is_expected.to eq(expected) }
      end
    end
  end
end
