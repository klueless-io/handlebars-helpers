# frozen_string_literal: true

require 'handlebars/helpers/string_case_formatting/dasherize'

RSpec.describe Handlebars::Helpers::StringCaseFormatting::Dasherize do
  let(:value) { 'the quick brown fox' }

  it { is_expected.not_to be_nil }

  # convert to dash notation
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('the-quick-brown-fox') }

    it_behaves_like 'nil will parse to empty'

    it_behaves_like 'valid value will parse successfully',
                    'trailing number supplied',
                    'twenty five66',
                    'twenty-five66'

    it_behaves_like 'valid value will parse successfully',
                    'trailing space and number supplied',
                    'twenty five 66',
                    'twenty-five66'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:dasherize, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{dasherize .}}' }

    it { is_expected.to eq('the-quick-brown-fox') }
  end
end
