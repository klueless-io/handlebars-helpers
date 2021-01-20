# frozen_string_literal: true

require 'handlebars/helpers/comparison/lte'

RSpec.describe Handlebars::Helpers::Comparison::Lte do
  # Lte: (less than or equal to) Block helper that renders a block if `a` is **less than or equal to** `b`. If an inverse block is specified it will be rendered when falsy.
  describe '#parse' do
    subject { described_class.new.parse(lhs, rhs) }

    context 'as number' do
      let(:lhs) { 1 }
      let(:rhs) { 1 }

      context '1 <= 2' do
        let(:rhs) { 2 }
        it { is_expected.to be_truthy }
      end
      context '1 <= 1' do
        it { is_expected.to be_truthy }
      end
      context '0 <= 1' do
        let(:lhs) { 0 }
        it { is_expected.to be_truthy }
      end
    end
    context 'as string' do
      let(:rhs) { 'b' }

      context 'c <= b' do
        let(:lhs) { 'c' }
        it { is_expected.to be_falsey }
      end
      context 'b <= b' do
        let(:lhs) { 'b' }
        it { is_expected.to be_truthy }
      end
      context 'a <= b' do
        let(:lhs) { 'a' }
        it { is_expected.to be_truthy }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:lte, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{#if (lte purchase_price bank_account)}}you have enough funds{{^}}you do not have enough funds{{/if}}' }
    let(:data) { { purchase_price: purchase_price, bank_account: bank_account } }
    let(:bank_account) { 2000 }

    context 'buy a green apple' do
      let(:purchase_price) { 2 }
      it { is_expected.to eq('you have enough funds') }
    end

    context 'buy an apple computer' do
      let(:purchase_price) { 2000 }
      it { is_expected.to eq('you have enough funds') }
    end

    context 'buy an apple computer + green apple' do
      let(:purchase_price) { 2002 }
      it { is_expected.to eq('you do not have enough funds') }
    end
  end
end
