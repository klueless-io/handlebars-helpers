# frozen_string_literal: true

require 'handlebars/helpers/register_helpers'

RSpec.describe Handlebars::Helpers::RegisterHelpers do
  describe 'constructor' do
    context 'with register_all helpers' do
      let(:subject) { instance }

      let(:instance) { described_class.new }

      it { is_expected.not_to be_nil }

      describe '.handlebars' do
        let(:subject) { instance.handlebars }

        it { is_expected.not_to be_nil }

        describe '#compile' do
          let(:subject) { instance.handlebars.compile('{{camel .}} was here').call('david') }

          it { is_expected.to eq('David was here') }
        end
      end
    end

    context 'with custom helper' do
      let(:subject) { instance }

      let(:instance) do
        described_class.new do |register| # , handlebars|
          register.helper(:a, :c) { |_context, value| "**#{value}**" }
          register.helper(:b)     { |_context, value| "|#{value}|" }
        end
      end

      it { is_expected.not_to be_nil }

      describe '.handlebars' do
        let(:subject) { instance.handlebars }

        it { is_expected.not_to be_nil }

        describe '#compile' do
          let(:subject) { instance.handlebars.compile('{{a .}}{{b .}}{{c .}}').call('david') }

          it { is_expected.to eq('**david**|david|**david**') }
        end
      end
    end
  end
end
