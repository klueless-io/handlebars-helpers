# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/snake'

RSpec.describe Handlebars::Helpers::StringFormatting::Snake do
  let(:value) { 'the Quick brown Fox' }

  it { is_expected.not_to be_nil }

  # snake case the characters in the given 'string'.
  describe '#parse' do
    subject { described_class.new.parse(value) }

    it { is_expected.to eq('the_quick_brown_fox') }

    it_behaves_like 'nil will parse to empty'

    it_behaves_like 'valid value will parse successfully',
                    'trailing number supplied',
                    'twenty five66',
                    'twenty_five66'

    it_behaves_like 'valid value will parse successfully',
                    'trailing space and number supplied',
                    'twenty five 66',
                    'twenty_five66'

    it_behaves_like 'valid value will parse successfully',
                    'using dash notation as input',
                    'the-quick-brown-fox66',
                    'the_quick_brown_fox66'
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, value) do |register|
        register.helper(:snake, &described_class.new.handlebars_helper)
      end
    end
    let(:template) { '{{snake .}}' }

    it { is_expected.to eq('the_quick_brown_fox') }
  end
end
