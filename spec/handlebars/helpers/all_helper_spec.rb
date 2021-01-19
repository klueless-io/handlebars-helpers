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

      context 'backward_slash' do
        let(:template) { '{{backward_slash .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'slash_backward' do
        let(:template) { '{{slash_backward .}}' }

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

      context 'camel_upper' do
        let(:template) { '{{camel_upper .}}' }

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

      context 'sentence' do
        let(:template) { '{{sentence .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to lamel case with first word lowercase and following words uppercase' do
      let(:data) { 'The quick brown fox' }
      let(:expected) { 'theQuickBrownFox' }
      context 'lamel' do
        let(:template) { '{{lamel .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'camel_lower' do
        let(:template) { '{{camel_lower .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'camelLower' do
        let(:template) { '{{camelLower .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'camelL' do
        let(:template) { '{{camelL .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to slash notation, aka forward slash' do
      let(:data) { 'the Quick brown Fox' }
      let(:expected) { 'the/Quick/brown/Fox' }
      context 'slash' do
        let(:template) { '{{slash .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'forward_slash' do
        let(:template) { '{{forward_slash .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'slash_forward' do
        let(:template) { '{{slash_forward .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'convert to snake notation' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'the_quick_brown_fox' }
      context 'snake' do
        let(:template) { '{{snake .}}' }

        it { is_expected.to eq(expected) }
      end
    end

    describe 'value converted to titleize case, aka heading case' do
      let(:data) { 'the quick brown fox' }
      let(:expected) { 'The Quick Brown Fox' }
      context 'titleize' do
        let(:template) { '{{titleize .}}' }

        it { is_expected.to eq(expected) }
      end

      context 'heading' do
        let(:template) { '{{heading .}}' }

        it { is_expected.to eq(expected) }
      end
    end
  end
end
