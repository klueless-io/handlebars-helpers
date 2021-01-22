# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/append_if'

RSpec.describe Handlebars::Helpers::StringFormatting::AppendIf do
  # Append If will append suffix to value, if value is not empty
  describe '#parse' do
    subject { described_class.new.parse(value, suffix, formats) }

    let(:value) { nil }
    let(:suffix) { ' fox' }
    let(:formats) { nil }

    context 'safely handle nil' do
      it { is_expected.to eq('') }
    end

    context 'when value and suffix' do
      let(:value) { 'the quick brown' }
      it { is_expected.to eq('the quick brown fox') }

      context 'format as' do
        context 'dashify' do
          let(:formats) { 'dashify' }
          let(:suffix) { '-fox' }
          it { is_expected.to eq('the-quick-brown-fox') }
        end
        context 'dashify,upcase' do
          let(:formats) { 'dashify,upcase' }
          let(:suffix) { '-FOX' }
          it { is_expected.to eq('THE-QUICK-BROWN-FOX') }
        end
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:append_if, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{append_if value suffix formats}}' }
    let(:data) { { value: value, suffix: suffix, formats: formats } }
    let(:value) { nil }
    let(:suffix) { nil }
    let(:formats) { nil }

    context 'when no value' do
      it { is_expected.to eq('') }
    end

    context 'when value and suffix' do
      let(:template) { '{{append_if value suffix}}' }

      let(:value) { 'product category' }
      let(:suffix) { ':' }

      it { is_expected.to eq('product category:') }

      context 'when format' do
        let(:template) { '{{append_if value suffix formats}}' }

        context 'with single format' do
          let(:formats) { 'snake' }
          it { is_expected.to eq('product_category:') }
        end

        context 'and chained formats' do
          let(:formats) { 'snake,pluralize' }
          it { is_expected.to eq('product_categories:') }
        end
      end
    end

    context 'safe string' do
      let(:template) { '{{append_if value suffix}}' }
      let(:value) { '<happy>' }
      let(:suffix) { ' #' }
      it { is_expected.to eq('<happy> #') }
    end
  end
end
