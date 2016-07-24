require 'bank/models/user'

module Bank
  module Routes
    class User < Base
      create = -> do
        user = Bank::Models::User.create!(@payload)
        status 201
        json = {id: user.id.to_s}.to_json
      end

      post '/v1/users', &create
    end
  end
end
