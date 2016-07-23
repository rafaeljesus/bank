require 'jwt'
require 'bank/models/user'

module Bank
  module Routes
    class Token < Base
      create = -> do
        unless @payload['email'].present? || @payload['password'].present?
          return status 401
        end

        user = Bank::Models::User.find_by(email: @payload['email'])

        if user.nil?
          return status 401
        end

        token = JWT.encode({id: user.id.to_s}, 'none')
        json = {token: token}.to_json
      end

      post '/v1/token', &create
    end
  end
end
