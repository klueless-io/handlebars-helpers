# frozen_string_literal: true

require 'handlebars/helpers/string_case_formatting/constantize'

RSpec.describe Handlebars::Helpers::StringCaseFormatting::Constantize do
  let(:value) { 'the quick brown fox' }

  it { is_expected.not_to be_nil }

  # CONSTANT case the characters in the given 'string'.
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('THE_QUICK_BROWN_FOX') }

    it_behaves_like 'nil will parse to empty'

    it_behaves_like 'valid value will parse successfully',
                    'trailing number supplied',
                    'twenty five66',
                    'TWENTY_FIVE66'

    it_behaves_like 'valid value will parse successfully',
                    'trailing space and number supplied',
                    'twenty five 66',
                    'TWENTY_FIVE66'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:constantize, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{constantize .}}' }

    it { is_expected.to eq('THE_QUICK_BROWN_FOX') }
  end
end
