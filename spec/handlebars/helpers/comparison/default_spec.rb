# frozen_string_literal: true

require 'handlebars/helpers/comparison/default'

RSpec.describe Handlebars::Helpers::Comparison::Default do
  # Default: Returns the first value that is not nil or undefined, otherwise the 'default' value is returned.
  describe '#parse' do
    subject { described_class.new.parse(values) }

    # let(:value) { nil }
    # let(:default_value) { 'happy' }
    # let(:emotions)
    # let(:values) { value.is_a?(Array) ? value.push(default_value) : [value, default_value] }

    context 'only default value provided' do
      let(:values) { ['happy'] }

      it { is_expected.to eq('happy') }
    end

    context 'value and default value' do
      let(:values) { [value, default_value] }
      let(:value) { 'sad' }
      let(:default_value) { 'happy' }

      it { is_expected.to eq('sad') }

      context 'when first value is missing' do
        let(:value) { nil }

        it { is_expected.to eq('happy') }
      end
    end

    context 'list of values and default value' do
      let(:values) { [david, lisa, ben, default_value] }
      let(:david) { nil }
      let(:lisa) { nil }
      let(:ben) { nil }
      let(:default_value) { 'happy' }

      context 'default group emotion' do
        it { is_expected.to eq('happy') }

        context 'group emotion when ben is mad' do
          let(:ben) { 'mad' }

          it { is_expected.to eq('mad') }

          context 'and lisa is sad' do
            let(:lisa) { 'sad' }

            it { is_expected.to eq('sad') }
          end
        end
      end
    end
  end

  describe 'use as handlebars helper' do
    let(:subject) do
      Handlebars::Helpers::Template.render(template, data) do |register|
        register.helper(:default, &described_class.new.handlebars_helper)
      end
    end

    let(:template) { '{{default ben lisa default_value}}' }
    let(:data) { { ben: ben, lisa: lisa, default_value: default_value } }
    let(:ben) { nil }
    let(:lisa) { nil }
    let(:default_value) { 'happy' }

    context 'what mood are we in?' do
      context 'when mood for ben and lisa is unknown' do
        it { is_expected.to eq('happy') }
      end
      context "when lisa's mood is sad" do
        let(:lisa) { 'sad' }

        it { is_expected.to eq('sad') }

        context 'and bens mood is joyful' do
          let(:lisa) { 'joyful' }

          it { is_expected.to eq('joyful') }
        end
      end
    end

    context 'safe string' do
      let(:default_value) { '"happy"' }
      it { is_expected.to eq('"happy"') }
    end
  end
end
