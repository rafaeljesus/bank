require 'bank/entities/user'
require 'bank/support/token'

module Bank
  module Routes
    class Token < Base
      create = -> do
        valid = @payload['email'].present? && @payload['password'].present?
        return halt 401 unless valid

        user = Entity::User.find_by(email: @payload['email'])
        return halt 401 unless user

        token = Support::Token.encode(user)
        {token: token}.to_json
      end

      post '/v1/token', &create
    end
  end
end
