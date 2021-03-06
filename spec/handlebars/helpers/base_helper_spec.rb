# frozen_string_literal: true

require 'handlebars/helpers/base_helper'

RSpec.describe Handlebars::Helpers::BaseHelper do
  let(:subject) { described_class.new }

  describe 'initialize' do
    it { is_expected.not_to be_nil }

    describe '#handlebars_helper' do
      it { is_expected.to respond_to(:handlebars_helper) }
    end

    describe '#tokenizer' do
      it { is_expected.to respond_to(:tokenizer) }
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:xyz, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{xyz .}}' }

    context 'ordinary string' do
      let(:value) { 'value' }
      it { is_expected.to eq('value') }
    end

    context 'unsafe string' do
      let(:value) { '<value>' }
      it { is_expected.to eq('&lt;value&gt;') }
    end
  end
end
