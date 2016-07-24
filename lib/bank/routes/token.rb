require 'bank/models/user'
require 'bank/support/token'

module Bank
  module Routes
    class Token < Base
      create = -> do
        unless @payload['email'].present? || @payload['password'].present?
          return halt 401
        end

        user = Bank::Models::User.find_by(email: @payload['email'])

        if user.nil?
          return halt 401
        end

        token = Bank::Support::Token.encode(user)
        json = {token: token}.to_json
      end

      post '/v1/token', &create
    end
  end
end
