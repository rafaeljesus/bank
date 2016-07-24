require 'sinatra/base'
require 'sinatra/json'

require 'bank/version'
require 'bank/routes/index'
require 'bank/support/jwt_auth'

module Bank
  class Server < Sinatra::Application
    configure {set :server, :puma}
    configure do
      disable :method_override
      disable :static
      enable  :raise_errors
    end

    use Support::JwtAuth
    use Routes::Token
    use Routes::User
    use Routes::Account
  end
end
