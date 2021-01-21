# frozen_string_literal: true

require 'handlebars/helpers/code_ruby/classify'

RSpec.describe Handlebars::Helpers::CodeRuby::Classify do
  # Classify: Creates a class name from a plural table name like Rails does for table names to models.
  describe '#parse' do
    subject { described_class.new.parse(value) }

    let(:value) { nil }

    context 'safely handle nil' do
      it { is_expected.to eq('') }
    end

    context 'pluralized input' do
      context 'product_categories' do
        let(:value) { 'product_categories' }
        it { is_expected.to eq('ProductCategory') }
      end

      context 'productCategories' do
        let(:value) { 'productCategories' }
        it { is_expected.to eq('ProductCategory') }
      end

      context 'product-categories' do
        let(:value) { 'product-categories' }
        it { is_expected.to eq('ProductCategory') }
      end

      context 'product#categories' do
        let(:value) { 'product#categories' }
        it { is_expected.to eq('ProductCategory') }
      end
    end

    context 'singular input' do
      context 'product_category' do
        let(:value) { 'product_category' }
        it { is_expected.to eq('ProductCategory') }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:classify, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{classify value}}' }
    let(:data) { { value: value } }
    let(:value) { nil }

    context 'when nil' do
      it { is_expected.to eq('') }
    end
    context 'when product_categories' do
      let(:value) { 'product_categories' }
      it { is_expected.to eq('ProductCategory') }
    end
  end
end
