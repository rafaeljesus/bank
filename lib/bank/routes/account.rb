require 'bank/entities/account'

module Bank
  module Routes
    class Account < Base
      before do
        payload = request.env.values_at(:user).first
        user = Entity::User.find_by(id: payload['id'])
        return halt 401 unless user
      end

      create = -> do
        return status 442 unless Entity::Account.open(@payload)
        status 201
      end

      deposit = -> do
        account = Entity::Account.find(params['id'])
        return status 404 unless account
        return status 442 unless Entity::Account.deposit(account, @payload['amount'])
        {deposited: true}.to_json
      end

      withdraw = -> do
        account = Entity::Account.find(params['id'])
        return status 404 unless account
        return status 442 unless Entity::Account.withdraw(account, @payload['amount'])
        {withdrawn: true}.to_json
      end

      transfer = -> do
        account = Entity::Account.find(params['id'])
        return status 404 unless account

        recipient = Entity::Account.find(@payload['recipient_id'])
        return status 404 unless recipient

        return status 442 unless Entity::Account.transfer(account, recipient, @payload['amount'])
        {transfered: true}.to_json
      end

      post '/v1/accounts', &create
      post '/v1/accounts/:id/deposit', &deposit
      post '/v1/accounts/:id/withdraw', &withdraw
      post '/v1/accounts/:id/transfer', &transfer
    end
  end
end
