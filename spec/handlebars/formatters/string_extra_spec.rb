# frozen_string_literal: true

require 'handlebars/helpers/formatters/string_extra'

RSpec.describe Handlebars::Helpers::Formatters::StringExtra do
  let(:formatter) { Class.new.extend(described_class) }

  it { is_expected.not_to be_nil }

  describe '#append' do
    subject { formatter.camel(value, suffix) }

    let(:value) { 'name' }
    let(:suffix) { '.html' }

    it { is_expected.to eq('name.html') }

    context 'when nil value' do
      let(:value) { nil }
      it { is_expected.to eq('.html') }
    end

    context 'when nil suffix' do
      let(:suffix) { nil }
      it { is_expected.to eq('name') }
    end
  end
end
