# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/upcase'

RSpec.describe Handlebars::Helpers::StringFormatting::Upcase do
  let(:value) { 'the quick brown fox' }

  it { is_expected.not_to be_nil }

  # Upcase/Uppercase all of the characters in the given string.
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('THE QUICK BROWN FOX') }

    it_behaves_like 'nil will parse to empty'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:upcase, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{upcase .}}' }

    it { is_expected.to eq('THE QUICK BROWN FOX') }
  end
end
