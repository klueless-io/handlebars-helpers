# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/lamel'

RSpec.describe Handlebars::Helpers::StringFormatting::Lamel do
  let(:value) { 'The quick brown fox' }

  it { is_expected.not_to be_nil }

  # lamel case is the same as camel case except with the first character as lower case
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('theQuickBrownFox') }

    it_behaves_like 'nil will parse to empty'

    it_behaves_like 'valid value will parse successfully',
                    'trailing number supplied',
                    'twenty five66',
                    'twentyFive66'

    it_behaves_like 'valid value will parse successfully',
                    'trailing space and number supplied',
                    'twenty five 66',
                    'twentyFive66'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:lamel, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{lamel .}}' }

    it { is_expected.to eq('theQuickBrownFox') }
  end
end
