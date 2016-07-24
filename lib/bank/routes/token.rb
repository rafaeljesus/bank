require 'bank/models/user'
require 'bank/support/token'

module Bank
  module Routes
    class Token < Base
      create = -> do
        valid = @payload['email'].present? && @payload['password'].present?

        unless valid
          return halt 401
        end

        user = Models::User.find_by(email: @payload['email'])

        if user.nil?
          return halt 401
        end

        token = Support::Token.encode(user)
        json = {token: token}.to_json
      end

      post '/v1/token', &create
    end
  end
end
