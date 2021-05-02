# frozen_string_literal: true

require 'handlebars/helpers/inflection/pluralize'

RSpec.describe Handlebars::Helpers::Inflection::Pluralize do
  let(:value) { 'octopus' }

  it { is_expected.not_to be_nil }

  # Returns the plural form of the word in the string
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('octopi') }

    it_behaves_like 'nil will parse to empty'

    context 'when :symbol' do
      let(:value) { :octopus }

      it { is_expected.to eq('octopi') }
    end
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
