# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/back_slash'

RSpec.describe Handlebars::Helpers::StringFormatting::BackSlash do
  let(:value) { 'the quick brown fox' }

  # convert to back slash notation
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('the\quick\brown\fox') }

    it_behaves_like 'nil will parse to empty'

    it_behaves_like 'valid value will parse successfully',
                    'trailing number supplied',
                    'Twenty Five66',
                    'Twenty\Five66'

    it_behaves_like 'valid value will parse successfully',
                    'trailing space and number supplied',
                    'Twenty Five 66',
                    'Twenty\Five66'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:back_slash, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{back_slash .}}' }

    it { is_expected.to eq('the\quick\brown\fox') }
  end
end
