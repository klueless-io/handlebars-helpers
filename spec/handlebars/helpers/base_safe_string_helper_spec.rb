# frozen_string_literal: true

require 'handlebars/context'
require 'handlebars/safe_string'
require 'handlebars/helpers/base_safe_string_helper'

RSpec.describe Handlebars::Helpers::BaseSafeStringHelper do
  let(:subject) { described_class.new }

  describe 'initialize' do
    it { is_expected.not_to be_nil }
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
      it { is_expected.to eq('<value>') }
    end
  end
end
