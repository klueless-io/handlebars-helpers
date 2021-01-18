# frozen_string_literal: true

require 'handlebars/helpers/template'

RSpec.describe 'Handlebars::Helpers::AllHelper' do
  subject { Handlebars::Helpers::Template.render(template, data) }

  context 'Case modification string manipulation methods' do
    describe 'convert to back slash notation' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'the\quick\brown\fox' }
      context 'back_slash' do
        let(:template) { '{{back_slash .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to camel case with first word uppercase and following words uppercase' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'TheQuickBrownFox' }
      context 'camel' do
        let(:template) { '{{camel .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'camelUpper' do
        let(:template) { '{{camelUpper .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'camelU' do
        let(:template) { '{{camelU .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to constant case' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'THE_QUICK_BROWN_FOX' }
      context 'constantize' do
        let(:template) { '{{constantize .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'constant' do
        let(:template) { '{{constant .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to dash notation' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'the-quick-brown-fox' }
      context 'dasherize' do
        let(:template) { '{{dasherize .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'dashify' do
        let(:template) { '{{dashify .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert text to human case, aka sentence case' do
      let(:data) { 'the Quick Brown Fox' }
      let(:expected) { 'The quick brown fox' }
      context 'humanize' do
        let(:template) { '{{humanize .}}' }

        it { is_expected.to eq(expected) }
      end
    end
  end
end
