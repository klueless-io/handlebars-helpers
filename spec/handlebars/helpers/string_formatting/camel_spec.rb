# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/camel'

RSpec.describe Handlebars::Helpers::StringFormatting::Camel do
  let(:value) { 'the quick brown fox' }

  it { is_expected.not_to be_nil }

  # camel case the characters in the given 'string'.
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('TheQuickBrownFox') }

    it_behaves_like 'nil will parse to empty'

    it_behaves_like 'valid value will parse successfully',
                    'trailing number supplied',
                    'twenty five66',
                    'TwentyFive66'

    it_behaves_like 'valid value will parse successfully',
                    'trailing space and number supplied',
                    'twenty five 66',
                    'TwentyFive66'

    it_behaves_like 'valid value will parse successfully',
                    'alpha-numeric coded value with word separation',
                    'p02_ef4',
                    'P02Ef4'

    it_behaves_like 'valid value will parse successfully',
                    'alpha-numeric coded value without word separation',
                    'p02ef4',
                    'P02ef4'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:camel, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{camel .}}' }

    it { is_expected.to eq('TheQuickBrownFox') }
  end
end
