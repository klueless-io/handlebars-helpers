# frozen_string_literal: true

require 'handlebars/helpers/formatters/code_ruby'

RSpec.describe Handlebars::Helpers::Formatters::CodeRuby do
  shared_examples 'nil will parse to empty' do
    let(:value) { nil }

    it { is_expected.to eq('') }
  end

  let(:formatter) { Class.new.extend(described_class) }

  it { is_expected.not_to be_nil }

  context 'formatter methods' do
    describe '#classify' do
      subject { formatter.classify(value) }

      let(:value) { 'product_categories' }

      it { is_expected.to eq('ProductCategory') }

      it_behaves_like 'nil will parse to empty'
    end

    describe '#demodulize' do
      subject { formatter.demodulize(value) }

      let(:value) { 'ActiveSupport::Inflector::Inflections' }

      it { is_expected.to eq('Inflections') }

      it_behaves_like 'nil will parse to empty'
    end

    describe '#deconstantize' do
      subject { formatter.deconstantize(value) }

      let(:value) { 'Net::HTTP' }

      it { is_expected.to eq('Net') }

      it_behaves_like 'nil will parse to empty'
    end

    describe '#foreign_key' do
      subject { formatter.foreign_key(value) }

      let(:value) { 'Admin::Post' }

      it { is_expected.to eq('post_id') }
    end

    describe '#tableize' do
      subject { formatter.tableize(value) }

      let(:value) { 'ProductCategory' }

      it { is_expected.to eq('product_categories') }

      it_behaves_like 'nil will parse to empty'
    end
  end
end
