# frozen_string_literal: true

require 'handlebars/helpers/inflection/ordinalize'

RSpec.describe Handlebars::Helpers::Inflection::Ordinalize do
  # Ordinalize: Turns a number into an ordinal string used to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th.
  describe '#parse' do
    subject { described_class.new.parse(value) }

    let(:value) { nil }

    context 'safely handle nil' do
      it { is_expected.to eq('') }
    end

    context 'when integer' do
      context 'when 1' do
        let(:value) { 1 }
        it { is_expected.to eq('1st') }
      end
      context 'when 2' do
        let(:value) { 2 }
        it { is_expected.to eq('2nd') }
      end
      context 'when 3' do
        let(:value) { 3 }
        it { is_expected.to eq('3rd') }
      end
      context 'when 4' do
        let(:value) { 4 }
        it { is_expected.to eq('4th') }
      end
      context 'when 1001' do
        let(:value) { 1001 }
        it { is_expected.to eq('1001st') }
      end
    end

    context 'when string number' do
      context 'when 1' do
        let(:value) { '1' }
        it { is_expected.to eq('1st') }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:ordinalize, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{ordinalize value}}' }
    let(:data) { { value: value } }
    let(:value) { nil }

    context 'when nil' do
      it { is_expected.to eq('') }
    end
    context 'when 1' do
      let(:value) { '1' }
      it { is_expected.to eq('1st') }
    end
  end
end
