# frozen_string_literal: true

require 'handlebars/helpers/code_ruby/foreign_key'

RSpec.describe Handlebars::Helpers::CodeRuby::ForeignKey do
  # Foreign Key: Creates a foreign key name from a class name
  # +separate_class_name_and_id_with_underscore+ sets whether
  # the method should put '_' between the name and 'id'.
  describe '#parse' do
    subject { described_class.new.parse(class_name, class_id_underscored: class_id_underscored) }

    let(:class_name) { 'Message' }
    let(:class_id_underscored) { true }

    context 'sample classes' do
      context 'when class name only' do
        it { is_expected.to eq('message_id') }
      end

      context 'when namespaced class name only' do
        let(:class_name) { 'Admin::ProductCategory' }
        it { is_expected.to eq('product_category_id') }

        context 'when class and id are not underscored' do
          let(:class_id_underscored) { false }
          it { is_expected.to eq('product_categoryid') }
        end
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:foreign_key, &described_class.new.handlebars_helper)
      end
    end

    let(:data) { { class_name: class_name } }
    let(:class_name) { 'Admin::ProductCategory' }

    context 'when class_name only' do
      let(:template) { '{{foreign_key class_name}}' }

      it { is_expected.to eq('product_category_id') }
    end

    context 'when class_name with underscore: true for ID' do
      let(:template) { '{{foreign_key class_name true}}' }

      it { is_expected.to eq('product_category_id') }
    end

    context 'when class_name with underscore: false for ID' do
      let(:template) { '{{foreign_key class_name false}}' }

      it { is_expected.to eq('product_categoryid') }
    end
  end
end
