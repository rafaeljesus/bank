require 'bank/models/user'

module Bank
  module Routes
    class User < Base
      create = -> do
        Bank::Models::User.create!(@payload)
        status 201
        json = {created: true}.to_json
      end

      post '/v1/users', &create
    end
  end
end
