# frozen_string_literal: true

require 'handlebars/helpers/comparison/or'

RSpec.describe Handlebars::Helpers::Comparison::Or do
  let(:lhs) { nil }
  let(:rhs) { nil }

  # Or: Block helper that renders a block if **any of** the given values is truthy. If an inverse block is specified it will be rendered when falsy.
  describe '#parse' do
    subject { described_class.new.parse([lhs, rhs]) }

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

    context 'any' do
      let(:template) { '{{#if (or p1 p2 p3 p4)}}found{{/if}}' }

      context 'none' do
        let(:data) { { p1: nil, p2: nil, p3: nil, p4: nil } }

        it { is_expected.to eq('') }
      end

      context 'one paramater' do
        let(:data) { { p1: nil, p2: 'pick me', p3: nil, p4: nil } }

        it { is_expected.to eq('found') }
      end

      context 'multiple paramaters' do
        let(:data) { { p1: nil, p2: nil, p3: 'pick me', p4: 'or me' } }

        it { is_expected.to eq('found') }
      end

      context 'boolean falsey' do
        let(:data) { { p1: nil, p2: nil, p3: nil, p4: false } }

        it { is_expected.to eq('') }
      end

      context 'boolean true' do
        let(:data) { { p1: false, p2: nil, p3: nil, p4: true } }

        it { is_expected.to eq('found') }
      end
    end
  end
end
