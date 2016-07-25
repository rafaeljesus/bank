source 'https://rubygems.org'

ruby '2.3.1'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-json', require: 'sinatra/json'
gem 'jwt'
gem 'rake'
gem 'bank_db',
  git: 'git@github.com:rafaeljesus/bank_db.git',
  branch: 'master'

group :production do
  gem 'puma'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'codeclimate-test-reporter', require: nil
end
