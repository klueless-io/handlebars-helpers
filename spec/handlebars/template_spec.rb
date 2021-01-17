# frozen_string_literal: true

require 'handlebars/helpers/string_tokenizer'

RSpec.describe Handlebars::Helpers::Template do
  let(:subject) { described_class.render(template, data) }

  describe '#render template' do
    context 'basic template' do
      let(:data) { nil }
      let(:template) { 'David was here' }

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

    context 'basic template using array' do
      let(:data) { %w[Apples Oranges] }
      # let(:data) { [{fruit: 'Apples'}, {fruit: 'Oranges'}] }
      let(:template) { '{{#each .}}{{this}}{{/each}}' }

      it { expect(subject).to include('ApplesOranges') }
    end
  end
end
