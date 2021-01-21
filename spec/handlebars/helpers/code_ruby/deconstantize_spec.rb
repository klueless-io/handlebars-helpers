# frozen_string_literal: true

require 'handlebars/helpers/code_ruby/deconstantize'

RSpec.describe Handlebars::Helpers::CodeRuby::Deconstantize do
  # Deconstantize: Removes the rightmost segment from the constant expression in the string.
  describe '#parse' do
    subject { described_class.new.parse(value) }

    let(:value) { nil }

    context 'safely handle nil' do
      it { is_expected.to eq('') }
    end

    context 'sample constant expressions' do
      context 'when Net::HTTP' do
        let(:value) { 'Net::HTTP' }
        it { is_expected.to eq('Net') }
      end

      context 'when ::Net::HTTP' do
        let(:value) { '::Net::HTTP' }
        it { is_expected.to eq('::Net') }
      end

      context 'when ::String' do
        let(:value) { '::String' }
        it { is_expected.to eq('') }
      end

      context 'when String' do
        let(:value) { 'String' }
        it { is_expected.to eq('') }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:deconstantize, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{deconstantize value}}' }
    let(:data) { { value: value } }
    let(:value) { nil }

    context 'when nil' do
      it { is_expected.to eq('') }
    end

    context 'when Net::HTTP' do
      let(:value) { 'Net::HTTP' }
      it { is_expected.to eq('Net') }
    end
  end
end
