require 'bank/models/user'

module Bank
  module Routes
    class User < Base
      create = -> do
        begin
          user = Models::User.create!(@payload)
          status 201
          {id: user.id.to_s}.to_json
        rescue Mongoid::Errors::Validations => e
          status 442
          {errors: e.summary}.to_json
        end
      end

      post '/v1/users', &create
    end
  end
end
