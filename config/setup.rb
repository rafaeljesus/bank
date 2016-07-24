require 'bundler/setup'
require 'yaml'
require 'mongoid'

ENVIRONMENT = ENV['ENVIRONMENT'] || 'development'

$LOAD_PATH.unshift File.expand_path '../../lib', __FILE__
mongo_file = File.expand_path '../mongoid.yml', __FILE__

Mongoid.load!(mongo_file, ENVIRONMENT)
Mongoid.raise_not_found_error = false
