# frozen_string_literal: true

require 'handlebars/helpers/comparison/lt'

RSpec.describe Handlebars::Helpers::Comparison::Lt do
  # Lt: (less than) Block helper that renders a block if `a` is **less than** `b`. If an inverse block is specified it will be rendered when falsy.
  describe '#parse' do
    subject { described_class.new.parse(lhs, rhs) }

    context 'as number' do
      let(:lhs) { 1 }
      let(:rhs) { 1 }

      context '1 < 1' do
        it { is_expected.to be_falsey }
      end
      context '0 < 1' do
        let(:lhs) { 0 }
        it { is_expected.to be_truthy }
      end
    end
    context 'as string' do
      let(:lhs) { 'b' }
      let(:rhs) { 'b' }

      context 'b < b' do
        it { is_expected.to be_falsey }
      end
      context 'a < b' do
        let(:lhs) { 'a' }
        it { is_expected.to be_truthy }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:lt, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{#if (lt purchase_price bank_account)}}you have enough funds{{^}}you do not have enough funds{{/if}}' }
    let(:data) { { purchase_price: purchase_price, bank_account: bank_account } }
    let(:bank_account) { 100 }

    context 'buy a green apple' do
      let(:purchase_price) { 2 }
      it { is_expected.to eq('you have enough funds') }
    end

    context 'buy an apple computer' do
      let(:purchase_price) { 2000 }
      it { is_expected.to eq('you do not have enough funds') }
    end
  end
end
