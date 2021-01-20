# frozen_string_literal: true

require 'handlebars/helpers/comparison/gte'

RSpec.describe Handlebars::Helpers::Comparison::Gte do
  # Gte: (greater than or equal to) Block helper that renders a block if `a` is **greater than** `b`. If an inverse block is specified it will be rendered when falsy.
  describe '#parse' do
    subject { described_class.new.parse(lhs, rhs) }

    context 'as number' do
      let(:lhs) { 1 }
      let(:rhs) { 1 }

      context '1 >= 2' do
        let(:rhs) { 2 }
        it { is_expected.to be_falsey }
      end
      context '1 >= 1' do
        it { is_expected.to be_truthy }
      end
      context '1 >= 0' do
        let(:rhs) { 0 }
        it { is_expected.to be_truthy }
      end
    end
    context 'as string' do
      let(:rhs) { 'b' }

      context 'c >= b' do
        let(:lhs) { 'c' }
        it { is_expected.to be_truthy }
      end
      context 'b >= b' do
        let(:lhs) { 'b' }
        it { is_expected.to be_truthy }
      end
      context 'a >= b' do
        let(:lhs) { 'a' }
        it { is_expected.to be_falsey }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:gte, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{#if (gte current_weight obese_weight)}}you are obese{{^}}your weight is ok{{/if}}' }
    let(:data) { { current_weight: current_weight, obese_weight: obese_weight } }
    let(:obese_weight) { 110 }

    context 'when I am thin' do
      let(:current_weight) { 100 }
      it { is_expected.to eq('your weight is ok') }
    end

    context 'when I reach obese level' do
      let(:current_weight) { 110 }
      it { is_expected.to eq('you are obese') }
    end

    context 'when I am over obese level' do
      let(:current_weight) { 120 }
      it { is_expected.to eq('you are obese') }
    end
  end
end
