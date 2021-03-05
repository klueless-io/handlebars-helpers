# frozen_string_literal: true

require 'handlebars/helpers/code_javascript/as_javascript'

RSpec.describe Handlebars::Helpers::CodeJavascript::AsJavascript do
  let(:javascript_exclude_root) do
    <<~JAVASCRIPT.strip
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
    JAVASCRIPT
  end
  let(:javascript) do
    <<~JAVASCRIPT.strip
      {
        #{javascript_exclude_root}
      }
    JAVASCRIPT
  end

  let(:expected_javascript) { javascript.gsub(/\s/, '') }
  let(:expected_javascript_exclude_root) { javascript_exclude_root.gsub(/\s/, '') }

  # take ruby object and write it out as Javascript notation
  describe '#parse' do
    subject { described_class.new.parse(value, format).gsub(/\s/, '') }

    let(:value) { nil }
    let(:format) { nil }

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

        context 'with format: exclude_root' do
          let(:format) { :exclude_root }
          it { is_expected.to eq expected_javascript_exclude_root }
        end
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
      content = Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:as_javascript, &described_class.new.handlebars_helper)
      end
      content.gsub(/\s/, '')
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
