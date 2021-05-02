# frozen_string_literal: true

require 'handlebars/helpers/inflection/singularize'

RSpec.describe Handlebars::Helpers::Inflection::Singularize do
  let(:value) { 'octopi' }

  it { is_expected.not_to be_nil }

  # The reverse of #pluralize, returns the singular form of a word in a string
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('octopus') }

    it_behaves_like 'nil will parse to empty'

    context 'when :symbol' do
      let(:value) { :octopi }

      it { is_expected.to eq('octopus') }
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:singularize, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{singularize .}}' }

    it { is_expected.to eq('octopus') }
  end
end
