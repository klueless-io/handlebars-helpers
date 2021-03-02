# frozen_string_literal: true

require 'handlebars/helpers/misc/json'

RSpec.describe Handlebars::Helpers::Misc::Json do
  # take handlebars object and write it out as JSON
  describe '#parse' do
    subject { described_class.new.parse(value) }

    let(:value) { nil }

    context 'safely handle nil' do
      it { is_expected.to eq('') }
    end

    context 'data hash is supplied' do
      context 'when complex data' do
        let(:value) do
          {
            david: 'was here',
            why: %w[reason1 reason2 reason3]
          }
        end

        it { is_expected.to eq('{"david":"was here","why":["reason1","reason2","reason3"]}') }
      end

      context 'when complex and deep data' do
        let(:value) do
          {
            david: 'was here',
            why: %w[reason1 reason2 reason3]
          }
        end

        it { is_expected.to eq('{"david":"was here","why":["reason1","reason2","reason3"]}') }
      end
    end

    context 'OpenStruct is supplied' do
      context 'when complex data' do
        let(:value) do
          OpenStruct.new(
            david: 'was here',
            why: %w[reason1 reason2 reason3],
            job: OpenStruct.new(name: 'developer', languages: ['C#', 'Ruby'])
          )
        end

        it { is_expected.to eq('{"david":"was here","why":["reason1","reason2","reason3"],"job":{"name":"developer","languages":["C#","Ruby"]}}') }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:json, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{json value}}' }
    let(:data) { { value: value } }
    let(:value) { nil }

    context 'when nil' do
      it { is_expected.to eq('') }
    end
    context 'when complex data' do
      let(:value) do
        {
          david: 'was here',
          why: %w[reason1 reason2 reason3]
        }
      end
      it { is_expected.to eq('{"david":"was here","why":["reason1","reason2","reason3"]}') }
    end
  end
end
