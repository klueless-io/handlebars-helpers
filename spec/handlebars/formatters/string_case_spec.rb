# frozen_string_literal: true

require 'handlebars/helpers/formatters/string_case'
require 'handlebars/helpers/string_tokenizer'

class CustomTokenizer
  def self.parse(value, preserve_case: false)
    value.parameterize(separator: '-xxx-', preserve_case: preserve_case)
  end
end

RSpec.describe Handlebars::Helpers::Formatters::StringCase do
  shared_examples 'nil will parse to empty' do
    let(:value) { nil }

    it { is_expected.to eq('') }
  end

  shared_examples 'valid value will parse successfully' do |label, value, expected_value|
    let(:value) { value }

    context "when #{label}" do
      it { is_expected.to eq(expected_value) }
    end
  end

  let(:formatter) { Class.new.extend(described_class) }
  let(:value) { 'the quick brown fox' }

  it { is_expected.not_to be_nil }

  describe '#tokenizer' do
    subject { tokenizer }

    let(:tokenizer) { formatter.tokenizer }

    it { is_expected.not_to be_nil }
    it { is_expected.to eq(Handlebars::Helpers::StringTokenizer) }

    describe '#parse' do
      subject { tokenizer.parse('The Quick') }

      it { is_expected.to eq('the-quick') }
    end

    context 'with custom tokenizer' do
      before { formatter.tokenizer = CustomTokenizer }

      it { is_expected.to eq(CustomTokenizer) }

      describe '#parse' do
        subject { tokenizer.parse('The Quick') }

        it { is_expected.to eq('the-xxx-quick') }
      end
    end
  end

  context 'case change methods' do
    describe '#camel' do
      subject { formatter.camel(value) }

      it { is_expected.to eq('TheQuickBrownFox') }

      it_behaves_like 'nil will parse to empty'
      it_behaves_like 'valid value will parse successfully',
                      'trailing number',
                      'twenty five66',
                      'TwentyFive66'
      it_behaves_like 'valid value will parse successfully',
                      'trailing space and number',
                      'twenty five 66',
                      'TwentyFive66'
    end

    describe '#lamel' do
      subject { formatter.lamel(value) }

      it { is_expected.to eq('theQuickBrownFox') }

      it_behaves_like 'nil will parse to empty'
      it_behaves_like 'valid value will parse successfully',
                      'trailing number',
                      'Twenty Five66',
                      'twentyFive66'
      it_behaves_like 'valid value will parse successfully',
                      'trailing space and number',
                      'Twenty Five 66',
                      'twentyFive66'
    end

    describe '#snake' do
      subject { formatter.snake(value) }

      it { is_expected.to eq('the_quick_brown_fox') }

      it_behaves_like 'nil will parse to empty'
      it_behaves_like 'valid value will parse successfully',
                      'trailing number',
                      'TwentyFive66',
                      'twenty_five66'
      it_behaves_like 'valid value will parse successfully',
                      'trailing space and number',
                      'Twenty Five 66',
                      'twenty_five66'
    end

    describe '#slash' do
      subject { formatter.slash(value) }

      it { is_expected.to eq('the/quick/brown/fox') }

      it_behaves_like 'nil will parse to empty'
      it_behaves_like 'valid value will parse successfully',
                      'trailing number',
                      'TwentyFive66',
                      'Twenty/Five66'
      it_behaves_like 'valid value will parse successfully',
                      'trailing space and number',
                      'Twenty Five 66',
                      'Twenty/Five66'
    end

    describe '#back_slash' do
      subject { formatter.back_slash(value) }

      it { is_expected.to eq('the\\quick\\brown\\fox') }

      it_behaves_like 'nil will parse to empty'
      it_behaves_like 'valid value will parse successfully',
                      'trailing number',
                      'TwentyFive66',
                      'Twenty\\Five66'
      it_behaves_like 'valid value will parse successfully',
                      'trailing space and number',
                      'Twenty Five 66',
                      'Twenty\\Five66'
    end
  end
end
