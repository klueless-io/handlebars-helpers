# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/downcase'

RSpec.describe Handlebars::Helpers::StringFormatting::Downcase do
  let(:value) { 'The Quick Brown Fox' }

  it { is_expected.not_to be_nil }

  # Downcase/Lowercase all of the characters in the given string.
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('the quick brown fox') }

    it_behaves_like 'nil will parse to empty'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:downcase, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{downcase .}}' }

    it { is_expected.to eq('the quick brown fox') }
  end
end
