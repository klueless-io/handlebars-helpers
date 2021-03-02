# frozen_string_literal: true

require 'handlebars/helpers/code_javascript/as_javascript'

RSpec.describe Handlebars::Helpers::CodeJavascript::AsJavascript do
  let(:expected_javascript) do
    <<~JAVASCRIPT.strip
      {
        david: "was here",
        why: [
          "reason1",
          "reason2",
          "reason3"
        ],
        job: {
          name: "developer",
          languages: [
            "C#",
            "Ruby"
          ]
        }
      }#{'        '}
    JAVASCRIPT
  end

  # take ruby object and write it out as Javascript notation
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
            why: %w[reason1 reason2 reason3],
            job: { name: 'developer', languages: ['C#', 'Ruby'] }
          }
        end

        it { is_expected.to eq expected_javascript }
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

        it { is_expected.to eq expected_javascript }
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:as_javascript, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{as_javascript value}}' }
    let(:data) { { value: value } }
    let(:value) { nil }

    context 'when nil' do
      it { is_expected.to eq('') }
    end
    context 'when complex data' do
      let(:value) do
        {
          david: 'was here',
          why: %w[reason1 reason2 reason3],
          job: { name: 'developer', languages: ['C#', 'Ruby'] }
        }
      end
      it { is_expected.to eq expected_javascript }
    end
  end
end
