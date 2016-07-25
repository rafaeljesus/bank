$: << File.join(File.expand_path('../', __FILE__), 'lib')

require 'bank_db'

require_relative 'lib/bank'

run Bank::Server
