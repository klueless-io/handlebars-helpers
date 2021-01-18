# frozen_string_literal: true

require 'handlebars/helpers/string_case_formatting/humanize'

RSpec.describe Handlebars::Helpers::StringCaseFormatting::Humanize do
  let(:value) { 'the Quick brown Fox' }

  it { is_expected.not_to be_nil }

  # humanize wil convert text to human case, aka sentence case
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('The quick brown fox') }

    it_behaves_like 'nil will parse to empty'

    it_behaves_like 'valid value will parse successfully',
                    'trailing number supplied',
                    'twenty five66',
                    'Twenty five66'

    it_behaves_like 'valid value will parse successfully',
                    'trailing space and number supplied',
                    'twenty five 66',
                    'Twenty five 66'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:humanize, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{humanize .}}' }

    it { is_expected.to eq('The quick brown fox') }
  end
end
