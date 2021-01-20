# frozen_string_literal: true

require 'handlebars/helpers/string_tokenizer'
require 'handlebars/helpers/string_formatting/camel'

RSpec.describe Handlebars::Helpers::Template do
  let(:subject) { described_class.render(template, data) }

  describe '#render template' do
    context 'basic template' do
      let(:data) { nil }
      let(:template) { 'David was here' }

      it { expect(subject).to include('David was here') }

      context 'basic template using string' do
        let(:data) { 'David' }
        let(:template) { '{{.}} was here' }

        it { expect(subject).to include('David was here') }
      end

      context 'basic template using hash' do
        let(:data) { { name: 'David' } }
        let(:template) { '{{name}} was here' }

        it { expect(subject).to include('David was here') }
      end

      context 'basic template using open struct' do
        let(:data) { OpenStruct.new(first_name: 'David', last_name: 'Cruwys') }
        let(:template) { '{{first_name}} {{last_name}} was here' }

        it { expect(subject).to include('David Cruwys was here') }
      end

      context 'basic template using array of strings' do
        let(:data) { %w[Apples Oranges] }
        # let(:data) { [{fruit: 'Apples'}, {fruit: 'Oranges'}] }
        let(:template) { '{{#each .}}{{this}}{{/each}}' }

        it { expect(subject).to include('ApplesOranges') }
      end

      context 'basic template using array of hashes' do
        let(:data) { [{ fruit: 'Apples' }, { fruit: 'Oranges' }] }
        let(:template) { '{{#each .}}{{this.fruit}}{{/each}}' }

        it { expect(subject).to include('ApplesOranges') }
      end

      context 'basic template using array of struct' do
        let(:data) do
          [
            OpenStruct.new(first_name: 'David', last_name: 'Cruwys'),
            OpenStruct.new(first_name: 'Fred', last_name: 'Frog')
          ]
        end
        let(:template) { '{{#each .}}{{this.last_name}}{{/each}}' }

        it { expect(subject).to include('CruwysFrog') }
      end
    end

    context 'template with helper' do
      let(:data) { { name: 'the quick brown fox' } }

      context 'camel helper' do
        let(:template) { '{{camel name}}' }

        it { expect(subject).to include('TheQuickBrownFox') }
      end

      context 'camelUpper helper (alias)' do
        let(:template) { '{{camelUpper name}}' }

        it { expect(subject).to include('TheQuickBrownFox') }
      end
    end
  end
end
