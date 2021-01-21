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
    # describe '#foreign_key' do
    #   subject { formatter.foreign_key(value) }

    #   let(:value) { 'Admin::Post' }

    #   it { is_expected.to eq('post_id') }
    # end

    # describe '#tableize' do
    #   subject { formatter.tableize(value) }

    #   let(:value) { 'ProductCategory' }

    #   it { is_expected.to eq('product_categories') }

    #   it_behaves_like 'nil will parse to empty'
    # end
  end
end
