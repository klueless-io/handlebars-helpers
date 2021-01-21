# frozen_string_literal: true

require 'handlebars/helpers/configuration'
require 'handlebars/helpers/string_formatting/camel'

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
  describe '.helper_config_file' do
    subject { Handlebars::Helpers.configuration.helper_config_file }

    it { is_expected.to eq('.handlebars_helpers.json') }

    context 'custom helper_config_file' do
      before :each do
        Handlebars::Helpers.configure do |config|
          config.helper_config_file = 'xxx.json'
        end
      end

      it { is_expected.to eq('xxx.json') }
    end
  end
  describe '.string_formatter_config_file' do
    subject { Handlebars::Helpers.configuration.string_formatter_config_file }

    it { is_expected.to eq('.handlebars_string_formatters.json') }

    context 'custom string_formatter_config_file' do
      before :each do
        Handlebars::Helpers.configure do |config|
          config.string_formatter_config_file = 'xxx.json'
        end
      end

      it { is_expected.to eq('xxx.json') }
    end
  end
  describe '.string_formatter_config' do
    subject { Handlebars::Helpers.configuration.string_formatter_config }

    it { is_expected.not_to be_nil }
    it { is_expected.to have_key(:camel) }

    it { is_expected.to include(camel: a_kind_of(Handlebars::Helpers::StringFormatting::Camel)) }
    it { is_expected.to include(pascalcase: a_kind_of(Handlebars::Helpers::StringFormatting::Camel)) }
    it { is_expected.to include(constantize: a_kind_of(Handlebars::Helpers::StringFormatting::Constantize)) }
    it { is_expected.to include(constant: a_kind_of(Handlebars::Helpers::StringFormatting::Constantize)) }
  end
  describe '.padl_count' do
    subject { Handlebars::Helpers.configuration.padl_count }

    it { is_expected.to eq(30) }
  end
  describe '.padl_char' do
    subject { Handlebars::Helpers.configuration.padl_char }

    it { is_expected.to eq(' ') }
  end
  describe '.padr_count' do
    subject { Handlebars::Helpers.configuration.padr_count }

    it { is_expected.to eq(30) }
  end
  describe '.padr_char' do
    subject { Handlebars::Helpers.configuration.padr_char }

    it { is_expected.to eq(' ') }
  end
end
