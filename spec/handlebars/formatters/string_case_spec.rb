# frozen_string_literal: true

require 'handlebars/helpers/formatters/string_case'
require 'handlebars/helpers/string_tokenizer'

class CustomTokenizer
  def self.parse(value)
    value.parameterize(separator: '-xxx-')
  end
end

RSpec.describe Handlebars::Helpers::Formatters::StringCase do
  RSpec.shared_examples 'nil safe' do
    context 'when nil' do
      let(:value) { nil }

      it { is_expected.to eq('') }
    end
  end

  shared_examples 'parse ok' do |label, value, expected_value|
    let(:value) { value }

    context "when #{label}" do
      it { is_expected.to eq(expected_value) }
    end
  end

  let(:formatter) { Class.new.extend(described_class) }
  let(:value) { 'the quick brown fox' }

  it { is_expected.not_to be_nil }

  describe '#tokenizer' do
    subject { formatter.tokenizer }

    it { is_expected.not_to be_nil }
    it { is_expected.to eq(Handlebars::Helpers::StringTokenizer) }
    it { expect(subject.parse('the quick')).to eq('the-quick') }

    context 'with custom tokenizer' do
      before { formatter.tokenizer = CustomTokenizer }

      it { is_expected.to eq(CustomTokenizer) }
      it { expect(subject.parse('the quick')).to eq('the-xxx-quick') }
    end
  end

  context 'case change methods' do
    describe '#camel' do
      subject { formatter.camel(value) }

      it { is_expected.to eq('TheQuickBrownFox') }

      it_behaves_like 'nil safe'
      it_behaves_like 'parse ok', 'trailing number'               , 'five66'  , 'Five66'
      it_behaves_like 'parse ok', 'trailing space and number'     , 'five 66' , 'Five66'
    end

    describe '#lamel' do
      subject { formatter.lamel(value) }

      it_behaves_like 'nil safe'
      it { is_expected.to eq('theQuickBrownFox') }
    end
  end
end
