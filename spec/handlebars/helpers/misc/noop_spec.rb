# frozen_string_literal: true

require 'handlebars/helpers/misc/noop'

RSpec.describe Handlebars::Helpers::Misc::Noop do
  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:noop, &described_class.new.handlebars_helper)
      end
    end

    let(:data) { { body: 'nice body' } }

    context 'when using normal content' do
      let(:template) { '{{#noop}}body [{{body}}] should parse{{/noop}}' }
      fit { is_expected.to eq('body [nice body] should parse') }
    end

    context 'when raw block escaping is used' do
      let(:template) { '{{{{noop}}}}nothing in [{{body}}] should be parsed{{{{/noop}}}}' }
      fit { is_expected.to eq('nothing in [{{body}}] should be parsed') }
    end
  end
end
