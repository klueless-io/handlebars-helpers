# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/pluralize'

RSpec.describe Handlebars::Helpers::StringFormatting::Pluralize do
  let(:value) { 'octopus' }

  it { is_expected.not_to be_nil }

  # Returns the plural form of the word in the string
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('octopi') }

    it_behaves_like 'nil will parse to empty'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:pluralize, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{pluralize .}}' }

    it { is_expected.to eq('octopi') }
  end
end
