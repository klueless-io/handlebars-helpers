# frozen_string_literal: true

require 'handlebars/helpers/comparison/eq'

RSpec.describe Handlebars::Helpers::Comparison::Eq do
  # Eq: Block helper that renders a block if `a` is **equal to** `b`. If an inverse block is specified it will be rendered when falsy.
  describe '#parse' do
    subject { described_class.new.parse(lhs, rhs) }

    let(:lhs) { nil }
    let(:rhs) { nil }

    context 'nil eq nil' do
      it { is_expected.to be_truthy }
    end

    context "'aaa' eq 'aaa'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'aaa' }

      it { is_expected.to be_truthy }
    end

    context "'aaa' eq 'AAA'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'AAA' }

      it { is_expected.to be_falsey }
    end

    context "'aaa' eq 'bbb'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'bbb' }

      it { is_expected.to be_falsey }
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:eq, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{#if (eq lhs rhs)}}SUCCESS: they are equal{{^}}FAIL: they are not equal{{/if}}' }
    let(:data) { { lhs: lhs, rhs: rhs } }
    let(:lhs) { nil }
    let(:rhs) { nil }

    context 'nil equal to nil' do
      it { is_expected.to eq('SUCCESS: they are equal') }
    end

    context "'aaa' equal to 'aaa'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'aaa' }

      it { is_expected.to eq('SUCCESS: they are equal') }
    end

    context "'aaa' equal to 'AAA'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'AAA' }

      it { is_expected.to eq('FAIL: they are not equal') }
    end
  end
end
