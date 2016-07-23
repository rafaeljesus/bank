require 'sinatra/base'
require 'sinatra/json'

require 'bank/version'
require 'bank/routes/index'

module Bank
  class App < Sinatra::Application
    configure {set :server, :puma}
    configure do
      disable :method_override
      disable :static
      enable  :raise_errors
    end

    use Routes::Token
    use Routes::User
    use Routes::Account
  end
end
