# frozen_string_literal: true

require 'handlebars/helpers/inflection/pluralize_by_number'

RSpec.describe Handlebars::Helpers::Inflection::PluralizeByNumber do
  # Pluralize By Number: uses both a word and number to decide if the plural or singular form should be used.
  describe '#parse' do
    subject { described_class.new.parse(value, count, format) }

    let(:value) { nil }
    let(:count) { 1 }
    let(:format) { nil }

    context 'safely handle nil value' do
      it { is_expected.to eq('') }
    end

    context 'when default format' do
      let(:value) { 'person' }
      context 'when one person' do
        let(:count) { 1 }
        it { is_expected.to eq('person') }

        context 'when 2 people' do
          let(:count) { 2 }
          it { is_expected.to eq('people') }
        end
      end
    end

    context 'when number_word format' do
      let(:format) { 'number_word' }
      let(:value) { 'person' }
      context 'when one person' do
        let(:count) { 1 }
        it { is_expected.to eq('1 person') }

        context 'when 2 people' do
          let(:count) { 2 }
          it { is_expected.to eq('2 people') }
        end
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:pluralize_by_number, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{pluralize_by_number value count format}}' }
    let(:data) { { value: value, count: count, format: format } }
    let(:value) { nil }
    let(:count) { nil }
    let(:format) { nil }

    context 'when value' do
      it { is_expected.to eq('') }
    end

    context 'when value is person' do
      let(:value) { 'person' }
      context 'when count is 1' do
        let(:count) { 1 }
        context 'when default format' do
          it { is_expected.to eq('person') }
        end
        context 'when number_word format' do
          let(:format) { 'number_word' }
          it { is_expected.to eq('1 person') }
        end
      end
      context 'when count is 2' do
        let(:count) { 2 }
        context 'when default format' do
          it { is_expected.to eq('people') }
        end
        context 'when number_word format' do
          let(:format) { 'number_word' }
          it { is_expected.to eq('2 people') }
        end
      end
    end
  end
end
