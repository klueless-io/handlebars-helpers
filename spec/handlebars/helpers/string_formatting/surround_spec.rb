# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/surround'

RSpec.describe Handlebars::Helpers::StringFormatting::Surround do
  # Surround will surround a value with prefix and suffix, empty value is considered valid data
  describe '#parse' do
    subject { described_class.new.parse(value, prefix, suffix, formats) }

    let(:value) { nil }
    let(:prefix) { '"' }
    let(:suffix) { '"' }
    let(:formats) { nil }

    context 'safely handle nil' do
      it { is_expected.to eq('""') }
    end
    context 'safely handle empty' do
      let(:value) { '' }
      it { is_expected.to eq('""') }
    end
    context 'safely handle 3 space' do
      let(:value) { '   ' }
      it { is_expected.to eq('"   "') }
    end
    context 'when value and suffix' do
      let(:value) { 'product category' }
      it { is_expected.to eq('"product category"') }

      context 'format as' do
        context 'dashify' do
          let(:formats) { 'dashify' }
          it { is_expected.to eq('"product-category"') }
        end
        context 'pluralize,upcase' do
          let(:formats) { 'pluralize,dashify' }
          it { is_expected.to eq('"product-categories"') }
        end
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:surround, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{surround value prefix suffix formats}}' }
    let(:data) { { value: value, prefix: prefix, suffix: suffix, formats: formats } }
    let(:value) { nil }
    let(:prefix) { '"' }
    let(:suffix) { '"' }
    let(:formats) { nil }

    context 'when no value' do
      it { is_expected.to eq('""') }
    end

    context 'when value and suffix' do
      let(:template) { '{{surround value prefix suffix}}' }

      let(:value) { 'product category' }
      let(:prefix) { '"' }
      let(:suffix) { '"' }

      it { is_expected.to eq('"product category"') }

      context 'when format' do
        let(:template) { '{{surround value prefix suffix formats}}' }

        context 'with single format' do
          let(:formats) { 'snake' }
          it { is_expected.to eq('"product_category"') }
        end

        context 'and chained formats' do
          let(:formats) { 'snake,pluralize' }
          it { is_expected.to eq('"product_categories"') }
        end
      end
    end

    context 'safe string' do
      let(:template) { '{{surround value prefix suffix}}' }
      let(:value) { '<happy>' }
      let(:prefix) { '[' }
      let(:suffix) { ']' }
      it { is_expected.to eq('[<happy>]') }
    end
  end
end
