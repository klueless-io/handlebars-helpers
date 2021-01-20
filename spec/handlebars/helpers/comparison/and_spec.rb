# frozen_string_literal: true

require 'handlebars/helpers/comparison/and'

RSpec.describe Handlebars::Helpers::Comparison::And do
  let(:lhs) { nil }
  let(:rhs) { nil }

  it { is_expected.not_to be_nil }

  # And: Block helper that renders a block if **all of** the given values are truthy. If an inverse block is specified it will be rendered when falsy.
  describe '#parse' do
    subject { described_class.new.parse([lhs, rhs]) }

    context 'nil && nil' do
      it { is_expected.to be_falsey }
    end
    context 'data && nil' do
      let(:lhs) { 'data' }
      it { is_expected.to be_falsey }
    end
    context 'nil && data' do
      let(:rhs) { 'data' }
      it { is_expected.to be_falsey }
    end
    context 'data && data' do
      let(:lhs) { 'data' }
      let(:rhs) { 'data' }
      it { is_expected.to be_truthy }
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:and, &described_class.new.handlebars_helper)
      end
    end

    let(:data) { { name: name, age: age } }
    let(:name) { nil }
    let(:age) { nil }

    let(:template) do
      <<~TEXT
        {{~#if (and name age)~}}
          {{name}}-{{age}}
        {{~^~}}
          no name and age
        {{~/if~}}
      TEXT
    end

    it { is_expected.to eq('no name and age') }

    context 'with name' do
      let(:name) { 'david' }
      it { is_expected.to eq('no name and age') }
    end

    context 'with age' do
      let(:age) { 49 }
      it { is_expected.to eq('no name and age') }
    end

    context 'with name and age' do
      let(:name) { 'david' }
      let(:age) { 49 }
      it { is_expected.to eq('david-49') }
    end

    context 'all' do
      let(:template) { '{{#if (and p1 p2 p3 p4)}}found{{/if}}' }

      context 'when all nil' do
        let(:data) { { p1: nil, p2: nil, p3: nil, p4: nil } }

        it { is_expected.to eq('') }
      end

      context 'when only one paramater' do
        let(:data) { { p1: nil, p2: 'pick me', p3: nil, p4: nil } }

        it { is_expected.to eq('') }
      end

      context 'when all all parameters are truthy, but one is false' do
        let(:data) { { p1: true, p2: false, p3: 'pick me', p4: 'and me' } }

        it { is_expected.to eq('') }
      end

      context 'when all all parameters are truthy' do
        let(:data) { { p1: true, p2: true, p3: 'pick me', p4: 'and me' } }

        it { is_expected.to eq('found') }
      end
    end
  end
end
