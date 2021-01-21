# frozen_string_literal: true

require 'handlebars/helpers/code_ruby/tableize'

RSpec.describe Handlebars::Helpers::CodeRuby::Tableize do
  # Tableize: Creates the name of a table like Rails does when converting models to table names
  describe '#parse' do
    subject { described_class.new.parse(value) }

    let(:value) { nil }

    context 'safely handle nil' do
      it { is_expected.to eq('') }
    end

    context 'sample model names' do
      context 'when post' do
        let(:value) { 'post' }
        it { is_expected.to eq('posts') }
      end

      context 'when product category' do
        let(:value) { 'product category' }
        it { is_expected.to eq('product_categories') }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:tableize, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{tableize value}}' }
    let(:data) { { value: value } }
    let(:value) { nil }

    context 'when nil' do
      it { is_expected.to eq('') }
    end
    context 'when product category' do
      let(:value) { 'product category' }
      it { is_expected.to eq('product_categories') }
    end

    context 'when product-category' do
      let(:value) { 'product-category' }
      it { is_expected.to eq('product_categories') }
    end

    context 'when product_category' do
      let(:value) { 'product_category' }
      it { is_expected.to eq('product_categories') }
    end
  end
end
