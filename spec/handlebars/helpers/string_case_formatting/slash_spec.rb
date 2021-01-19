# frozen_string_literal: true

require 'handlebars/helpers/string_case_formatting/slash'

RSpec.describe Handlebars::Helpers::StringCaseFormatting::Slash do
  let(:value) { 'the quick brown fox' }

  it { is_expected.not_to be_nil }

  # slash case the characters in the given 'string'.
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('the/quick/brown/fox') }

    it_behaves_like 'nil will parse to empty'

    it_behaves_like 'valid value will parse successfully',
                    'trailing number supplied',
                    'twenty Five66',
                    'twenty/Five66'

    it_behaves_like 'valid value will parse successfully',
                    'trailing space and number supplied',
                    'twenty Five 66',
                    'twenty/Five66'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:slash, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{slash .}}' }

    it { is_expected.to eq('the/quick/brown/fox') }
  end
end
