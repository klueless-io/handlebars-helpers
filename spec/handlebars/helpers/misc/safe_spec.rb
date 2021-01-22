# frozen_string_literal: true

require 'handlebars/helpers/misc/safe'

RSpec.describe Handlebars::Helpers::Misc::Safe do
  # Safe will return the value with <> and single and double quotes left as is
  describe '#parse' do
    subject { described_class.new.parse(value) }

    let(:value) { nil }

    context 'safely handle nil' do
      it { is_expected.to eq('') }
    end

    context 'value with characters that are considered safe' do
      context 'when <>' do
        let(:value) { '<hello>' }
        it { is_expected.to eq('<hello>') }
      end
      context 'when ""' do
        let(:value) { '"hello"' }
        it { is_expected.to eq('"hello"') }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:safe, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{safe value}}' }
    let(:data) { { value: value } }
    let(:value) { nil }

    context 'when nil' do
      it { is_expected.to eq('') }
    end
    context 'when value has <> or ""' do
      let(:value) { '"<hello>"' }
      it { is_expected.to eq('"<hello>"') }
    end
  end
end
