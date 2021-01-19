# frozen_string_literal: true

require 'handlebars/helpers/string_formatting/append'

RSpec.describe Handlebars::Helpers::StringFormatting::Append do
  let(:formatter) { described_class.new }

  it { is_expected.not_to be_nil }

  # Append the specified `suffix` to the given string
  describe '#parse' do
    subject { formatter.parse(value, suffix) }

    let(:value) { 'name' }
    let(:suffix) { '.html' }

    it { is_expected.to eq('name.html') }
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:append, &formatter.handlebars_helper)
      end
    end
    let(:data) { { p1: 'name', p2: '.html' } }
    let(:template) { '{{append p1 p2}}' }

    it { is_expected.to eq('name.html') }
  end
end
