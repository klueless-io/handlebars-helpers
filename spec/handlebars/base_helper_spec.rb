# frozen_string_literal: true

require 'handlebars/helpers/base_helper'

RSpec.describe Handlebars::Helpers::BaseHelper do
  let(:subject) { described_class.new }

  describe 'initialize' do
    it { is_expected.not_to be_nil }

    describe '#handlebars_helper' do
      it { is_expected.to respond_to(:handlebars_helper) }
    end
  end
end
