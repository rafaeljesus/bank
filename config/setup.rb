require 'bundler/setup'
require 'yaml'
require 'mongoid'

ENVIRONMENT = ENV['ENVIRONMENT'] || 'development'

$LOAD_PATH.unshift File.expand_path '../../lib', __FILE__
mongo_file = File.expand_path '../mongoid.yml', __FILE__
p ENVIRONMENT
p mongo_file
Mongoid.load!(mongo_file, ENVIRONMENT)
