require 'rubygems'
require 'bundler'
require 'rack/test'
require 'codeclimate-test-reporter'

ENV['RACK_ENV'] = 'test'
ENV['ENVIRONMENT'] = 'test'
ENV['JWT_SECRET'] = 'foo'

require 'bank_db'
require 'bank'
require 'support/request_helper'

CodeClimate::TestReporter.start

Bundler.require(:default, ENV['RACK_ENV'])

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :transaction

RSpec.configure do |config|
  config.include Request::JsonHelper
  config.include FactoryGirl::Syntax::Methods
  config.include Rack::Test::Methods
  config.order = :random

  def app
    Rack::Builder.parse_file('config.ru').first
  end

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.before(:suite) do
    DatabaseCleaner.start
  end

  config.after(:suite) do
    DatabaseCleaner.clean
  end

  config.expect_with(:rspec) do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with(:rspec) do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
    mocks.verify_doubled_constant_names = true
  end
end
