# frozen_string_literal: true

RSpec.describe Handlebars::Helpers do
  it 'has a version number' do
    expect(Handlebars::Helpers::VERSION).not_to be nil
  end

  it 'has a standard error' do
    expect { raise Handlebars::Helpers::Error, 'some message' }
      .to raise_error('some message')
  end
end
