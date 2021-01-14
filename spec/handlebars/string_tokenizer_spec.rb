# frozen_string_literal: true

require 'handlebars/helpers/string_tokenizer'

RSpec.describe Handlebars::Helpers::StringTokenizer do
  let(:subject) { described_class.parse(value) }

  context 'with character handling' do
    context 'when nil' do
      let(:value) { nil }

      it { is_expected.to eq('') }
    end

    context 'when given a natural sentence' do
      let(:value) { 'the quick brown fox' }

      it { is_expected.to eq('the-quick-brown-fox') }
    end

    context 'when given a natural sentence with extra spacing' do
      let(:value) { 'the  quick  brown  fox' }

      it { is_expected.to eq('the-quick-brown-fox') }
    end

    context 'when given a sentence with other characters' do
      let(:value) { 'abc _123-xyz~`!!@#$%^&*()+=' }

      it { is_expected.to eq('abc-_123-xyz') }
    end

    context 'when given a natural sentence each word starting uppercase' do
      let(:value) { 'The Quick Brown Fox' }

      it { is_expected.to eq('the-quick-brown-fox') }
    end

    context 'when given a natural sentence all words fully uppercased' do
      let(:value) { 'THE QUICK BROWN FOX' }

      it { is_expected.to eq('the-quick-brown-fox') }
    end
  end
end
