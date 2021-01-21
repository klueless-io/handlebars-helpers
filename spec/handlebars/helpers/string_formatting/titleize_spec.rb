# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/titleize'

RSpec.describe Handlebars::Helpers::StringFormatting::Titleize do
  let(:value) { 'the quick brown fox' }

  it { is_expected.not_to be_nil }

  # titleize case the characters in the given 'string', aka heading case
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('The Quick Brown Fox') }

    it_behaves_like 'nil will parse to empty'

    it_behaves_like 'valid value will parse successfully',
                    'trailing number supplied',
                    'twenty five66',
                    'Twenty Five66'

    it_behaves_like 'valid value will parse successfully',
                    'trailing space and number supplied',
                    'twenty five 66',
                    'Twenty Five 66'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:titleize, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{titleize .}}' }

    it { is_expected.to eq('The Quick Brown Fox') }
  end
end
