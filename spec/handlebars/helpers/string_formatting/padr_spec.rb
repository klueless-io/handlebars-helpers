# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/padr'

RSpec.describe Handlebars::Helpers::StringFormatting::Padr do
  # Add padding to the right of the value.
  describe '#parse' do
    subject { described_class.new.parse(value, count, char) }

    let(:value) { nil }
    let(:count) { nil }
    let(:char) { nil }

    context 'safely handle nil value' do
      it { is_expected.to eq('                              ') }
    end

    context 'when value supplied' do
      let(:value) { 'pad-me' }
      it { is_expected.to eq('pad-me                        ') }
      context 'when value is integer' do
        let(:value) { 123 }
        it { is_expected.to eq('123                           ') }
      end
      context 'when value is symbol' do
        let(:value) { :symbol }
        it { is_expected.to eq('symbol                        ') }
      end
      context 'and padding count' do
        let(:count) { 10 }
        it { is_expected.to eq('pad-me    ') }
        context 'and padding character' do
          let(:char) { '-' }
          it { is_expected.to eq('pad-me----') }
          context 'with padding count supplied as string' do
            let(:count) { '8' }
            it { is_expected.to eq('pad-me--') }
          end
        end
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:padr, &described_class.new.handlebars_helper)
      end
    end

    let(:data) { { value: value, count: count, char: char } }
    let(:value) { 'pad-me' }
    let(:count) { 10 }
    let(:char) { '#' }

    context 'when no value' do
      let(:template) { '{{padr}}' }
      it { is_expected.to eq('                              ') }
    end
    context 'when value' do
      let(:template) { '{{padr value}}' }
      it { is_expected.to eq('pad-me                        ') }
      context 'and custom count' do
        let(:template) { '{{padr value count}}' }
        it { is_expected.to eq('pad-me    ') }
        context 'and custom character' do
          let(:template) { '{{padr value count char}}' }
          it { is_expected.to eq('pad-me####') }
        end
      end
    end

    context 'safe string' do
      let(:template) { '{{padr value 10}}' }
      let(:value) { '"happy"' }
      it { is_expected.to eq('"happy"   ') }
    end
  end
end
