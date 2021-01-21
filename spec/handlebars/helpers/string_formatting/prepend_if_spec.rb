# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/prepend_if'

RSpec.describe Handlebars::Helpers::StringFormatting::PrependIf do
  # Prepend If will prepend the prefix to value, if value is not empty
  describe '#parse' do
    subject { described_class.new.parse(value, prefix, formats) }

    let(:value) { nil }
    let(:prefix) { '# ' }
    let(:formats) { nil }

    context 'safely handle nil' do
      it { is_expected.to eq('') }
    end

    context 'when value and prefix' do
      let(:value) { 'the quick brown fox' }
      it { is_expected.to eq('# the quick brown fox') }

      context 'format as' do
        context 'dashify' do
          let(:formats) { 'dashify' }
          it { is_expected.to eq('# the-quick-brown-fox') }
        end
        context 'pluralize,snake' do
          let(:formats) { 'pluralize,snake' }
          it { is_expected.to eq('# the_quick_brown_foxes') }
        end
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:prepend_if, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{prepend_if value prefix formats}}' }
    let(:data) { { value: value, prefix: prefix, formats: formats } }
    let(:value) { nil }
    let(:prefix) { nil }
    let(:formats) { nil }

    context 'when no value' do
      it { is_expected.to eq('') }
    end

    context 'when value and prefix' do
      let(:template) { '{{prepend_if value prefix}}' }

      let(:value) { 'product category' }
      let(:prefix) { ':' }

      it { is_expected.to eq(':product category') }

      context 'when format' do
        let(:template) { '{{prepend_if value prefix formats}}' }

        context 'with single format' do
          let(:formats) { 'snake' }
          it { is_expected.to eq(':product_category') }
        end

        context 'and chained formats' do
          let(:formats) { 'snake,pluralize' }
          it { is_expected.to eq(':product_categories') }
        end
      end
    end
  end
end
