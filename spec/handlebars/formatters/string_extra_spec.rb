# frozen_string_literal: true

require 'handlebars/helpers/formatters/string_extra'

RSpec.describe Handlebars::Helpers::Formatters::StringExtra do
  shared_examples 'nil will parse to empty' do
    let(:value) { nil }

    it { is_expected.to eq('') }
  end

  let(:formatter) { Class.new.extend(described_class) }

  it { is_expected.not_to be_nil }

  describe '#append' do
    subject { formatter.append(value, suffix) }

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

  describe '#pluralize' do
    subject { formatter.pluralize(value) }

    let(:value) { 'name' }

    it { is_expected.to eq('names') }

    it_behaves_like 'nil will parse to empty'

    context 'when octopus' do
      let(:value) { 'octopus' }

      it { is_expected.to eq('octopi') }
    end
  end

  describe '#singularize' do
    subject { formatter.singularize(value) }

    let(:value) { 'names' }

    it { is_expected.to eq('name') }

    it_behaves_like 'nil will parse to empty'

    context 'when octopi' do
      let(:value) { 'octopi' }

      it { is_expected.to eq('octopus') }
    end
  end
end
