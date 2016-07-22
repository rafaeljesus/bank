require 'jwt'
require 'bank/models/user'

module Bank
  module Routes
    class Token < Base
      create = -> do
        unless params[:email].present? && params[:password].present?
          return status 401
        end

        user = Bank::Models::User.find_by(email: params[:email])

        if user.nil?
          return status 401
        end

        token = JWT.encode(payload, {id: user._id}, 'none')
        json = {token: token}
      end

      post '/v1/token', &create
    end
  end
end
