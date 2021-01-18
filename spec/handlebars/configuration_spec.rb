# frozen_string_literal: true

require 'handlebars/helpers/configuration'

class ConfigurationSampleTokenizer
  def parse(value, preserve_case: false)
    value.parameterize(separator: '-xxx-', preserve_case: preserve_case)
  end
end

RSpec.describe Handlebars::Helpers::Configuration do
  after :each do
    Handlebars::Helpers.reset
  end

  describe '.tokenizer' do
    subject { Handlebars::Helpers.configuration.tokenizer }

    it { is_expected.to be_a(Handlebars::Helpers::StringTokenizer) }

    context 'custom tokenizer' do
      before :each do
        Handlebars::Helpers.configure do |config|
          config.tokenizer = ConfigurationSampleTokenizer.new
        end
      end

      it { is_expected.to be_a(ConfigurationSampleTokenizer) }
    end
  end
end
