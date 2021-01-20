# frozen_string_literal: true

require 'handlebars/helpers/comparison/gt'

RSpec.describe Handlebars::Helpers::Comparison::Gt do
  # Gt: (greater than) Block helper that renders a block if `a` is **greater than** `b`. If an inverse block is specified it will be rendered when falsy.
  describe '#parse' do
    subject { described_class.new.parse(lhs, rhs) }

    context 'as number' do
      let(:lhs) { 1 }
      let(:rhs) { 1 }

      context '1 > 1' do
        it { is_expected.to be_falsey }
      end
      context '2 > 1' do
        let(:lhs) { 2 }
        it { is_expected.to be_truthy }
      end
    end
    context 'as string' do
      let(:lhs) { 'b' }
      let(:rhs) { 'b' }

      context 'b > b' do
        it { is_expected.to be_falsey }
      end
      context 'b > a' do
        let(:rhs) { 'a' }
        it { is_expected.to be_truthy }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:gt, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{#if (gt purchase_price bank_account)}}you do not have enough funds{{^}}you have enough funds{{/if}}' }
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
