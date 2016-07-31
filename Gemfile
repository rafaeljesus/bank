source 'https://rubygems.org'

ruby '2.3.1'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-json', require: 'sinatra/json'
gem 'jwt'
gem 'rake'
gem 'bank_db',
  git: 'https://github.com/rafaeljesus/bank-db.git',
  branch: 'master'

group :production do
  gem 'puma'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'factory_girl'
  gem 'database_cleaner'
  gem 'codeclimate-test-reporter', require: nil
end
