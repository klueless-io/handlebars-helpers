# frozen_string_literal: true

require 'handlebars/helpers/comparison/ne'

RSpec.describe Handlebars::Helpers::Comparison::Ne do
  # Ne: (not equal) Block helper that renders a block if `a` is **not equal to** `b`. If an inverse block is specified it will be rendered when falsy.
  describe '#parse' do
    subject { described_class.new.parse(lhs, rhs) }

    let(:lhs) { nil }
    let(:rhs) { nil }

    context 'nil != nil' do
      it { is_expected.to be_falsey }
    end

    context "'aaa' != 'aaa'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'aaa' }

      it { is_expected.to be_falsey }
    end

    context ":aaa != 'aaa'" do
      let(:lhs) { :aaa }
      let(:rhs) { 'aaa' }

      it { is_expected.to be_falsey }
    end

    context "'aaa' != :aaa" do
      let(:lhs) { 'aaa' }
      let(:rhs) { :aaa }

      it { is_expected.to be_falsey }
    end

    context "'aaa' != 'AAA'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'AAA' }

      it { is_expected.to be_truthy }
    end

    context "'aaa' != 'bbb'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'bbb' }

      it { is_expected.to be_truthy }
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:ne, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{#if (ne lhs rhs)}}SUCCESS: these values are not equal{{^}}FAIL: these values are equal{{/if}}' }
    let(:data) { { lhs: lhs, rhs: rhs } }
    let(:lhs) { nil }
    let(:rhs) { nil }

    context 'nil != nil' do
      it { is_expected.to eq('FAIL: these values are equal') }
    end

    context "'aaa' != 'aaa'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'aaa' }

      it { is_expected.to eq('FAIL: these values are equal') }
    end

    context "'aaa' != 'AAA'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'AAA' }

      it { is_expected.to eq('SUCCESS: these values are not equal') }
    end
  end
end
