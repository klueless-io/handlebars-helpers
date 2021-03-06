# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/dotirize'

RSpec.describe Handlebars::Helpers::StringFormatting::Dotirize do
  let(:value) { 'the quick brown fox' }

  it { is_expected.not_to be_nil }

  # convert to dot notation
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('the.quick.brown.fox') }

    it_behaves_like 'nil will parse to empty'

    it_behaves_like 'valid value will parse successfully',
                    'trailing number supplied',
                    'twenty five66',
                    'twenty.five66'

    it_behaves_like 'valid value will parse successfully',
                    'trailing space and number supplied',
                    'twenty five 66',
                    'twenty.five66'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:dotirize, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{dotirize .}}' }

    it { is_expected.to eq('the.quick.brown.fox') }
  end
end
