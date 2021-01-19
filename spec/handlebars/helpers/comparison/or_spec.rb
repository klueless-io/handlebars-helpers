# frozen_string_literal: true

require 'handlebars/helpers/comparison/or'

RSpec.describe Handlebars::Helpers::Comparison::Or do
  let(:lhs) { nil }
  let(:rhs) { nil }

  it { is_expected.not_to be_nil }

  # Or: Block helper that renders a block if **any of** the given values is truthy. If an inverse block is specified it will be rendered when falsy.
  describe '#parse' do
    subject { described_class.new.parse(lhs, rhs) }

    context 'nil || nil' do
      it { is_expected.to be_falsey }
    end
    context 'data || nil' do
      let(:lhs) { 'data' }
      it { is_expected.to be_truthy }
    end
    context 'nil || data' do
      let(:rhs) { 'data' }
      it { is_expected.to be_truthy }
    end
    context 'data || data' do
      let(:lhs) { 'data' }
      let(:rhs) { 'data' }
      it { is_expected.to be_truthy }
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:or, &described_class.new.handlebars_helper)
      end
    end

    let(:data) { { name: name, age: age } }
    let(:name) { nil }
    let(:age) { nil }

    let(:template) do
      <<~TEXT
        {{~#if (or name age)~}}
          {{name}}-{{age}}
        {{~^~}}
          no name or age
        {{~/if~}}
      TEXT
    end

    it { is_expected.to eq('no name or age') }

    context 'with name' do
      let(:name) { 'david' }
      it { is_expected.to eq('david-') }
    end

    context 'with age' do
      let(:age) { 49 }
      it { is_expected.to eq('-49') }
    end

    context 'with name and age' do
      let(:name) { 'david' }
      let(:age) { 49 }
      it { is_expected.to eq('david-49') }
    end
  end
end
