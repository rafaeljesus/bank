require 'rubygems'
require 'bundler'
require 'rack/test'
require 'codeclimate-test-reporter'

ENV['RACK_ENV'] = 'test'
ENV['ENVIRONMENT'] = 'test'
ENV['JWT_SECRET'] = 'foo'

require 'bank_db'
require 'bank'

CodeClimate::TestReporter.start

Bundler.require(:default, ENV['RACK_ENV'])

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.order = :random

  def app
    Rack::Builder.parse_file('config.ru').first
  end

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
    mocks.verify_doubled_constant_names = true
  end
end
