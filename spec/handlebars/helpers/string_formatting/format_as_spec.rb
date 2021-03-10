# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/format_as'

RSpec.describe Handlebars::Helpers::StringFormatting::FormatAs do
  # Format As: Chain a list of string formatters to run sequentially
  describe '#parse' do
    subject { described_class.new.parse(value, formats) }

    let(:value) { nil }
    let(:formats) { nil }

    context 'safely handle nil value' do
      it { is_expected.to eq('') }
    end

    context 'with value' do
      let(:value) { 'the quick brown fox' }
      context 'safely handle nil format' do
        it { is_expected.to eq('the quick brown fox') }
      end
      context 'safely handle invalid format' do
        let(:formats) { 'unknown' }
        it { is_expected.to eq('the quick brown fox') }
      end
      context 'safely handle none format' do
        let(:formats) { 'none' }
        it { is_expected.to eq('the quick brown fox') }
      end
      context 'with format: camel' do
        let(:formats) { 'camel' }
        it { is_expected.to eq('TheQuickBrownFox') }
      end
      context 'with format: camel,pluralize,snake' do
        let(:formats) { 'camel,pluralize,snake' }
        it { is_expected.to eq('the_quick_brown_foxes') }
      end
      context 'with format: camel,pluralize,dashify' do
        let(:formats) { 'camel,pluralize,dashify' }
        it { is_expected.to eq('the-quick-brown-foxes') }
      end
      context 'with format: camel,pluralize,dotify' do
        let(:formats) { 'camel,pluralize,dotify' }
        it { is_expected.to eq('the.quick.brown.foxes') }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:format_as, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{format_as value formats}}' }
    let(:data) { { value: value, formats: formats } }
    let(:value) { nil }
    let(:formats) { nil }

    context 'when nil' do
      it { is_expected.to eq('') }
    end
    context 'when value and formats' do
      let(:value) { 'the quick brown fox' }
      let(:formats) { 'camel,pluralize,snake' }
      it { is_expected.to eq('the_quick_brown_foxes') }
    end

    context 'using format directly in the template' do
      let(:template) { '{{format_as value "pluralize,snake"}}' }

      context 'with value' do
        let(:value) { 'the quick brown fox' }
        it { is_expected.to eq('the_quick_brown_foxes') }
      end
    end
  end
end
