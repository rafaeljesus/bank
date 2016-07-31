require 'bank/entities/user'

module Bank
  module Routes
    class User < Base
      create = -> do
        begin
          user = Entity::User.new(@payload)
          user.save!
          status 201
          user.to_json(only: [:id])
        rescue ActiveRecord::RecordInvalid => e
          status 442
          {errors: e.record.errors}.to_json
        end
      end

      post '/v1/users', &create
    end
  end
end
