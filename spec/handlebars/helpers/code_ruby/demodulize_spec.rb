# frozen_string_literal: true

require 'handlebars/helpers/code_ruby/demodulize'

RSpec.describe Handlebars::Helpers::CodeRuby::Demodulize do
  # Demodulize: Removes the module part from the expression in the string.
  describe '#parse' do
    subject { described_class.new.parse(value) }

    let(:value) { nil }

    context 'safely handle nil' do
      it { is_expected.to eq('') }
    end

    context 'sample inflections' do
      context 'module and class' do
        let(:value) { 'ActiveSupport::Inflector::Inflections' }
        it { is_expected.to eq('Inflections') }
      end

      context 'class only' do
        let(:value) { 'Inflections' }
        it { is_expected.to eq('Inflections') }
      end

      context 'root based class only' do
        let(:value) { '::Inflections' }
        it { is_expected.to eq('Inflections') }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:demodulize, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{demodulize value}}' }
    let(:data) { { value: value } }
    let(:value) { nil }

    context 'when nil' do
      it { is_expected.to eq('') }
    end
    context 'when module and class' do
      let(:value) { 'ActiveSupport::Inflector::Inflections' }
      it { is_expected.to eq('Inflections') }
    end
  end
end
