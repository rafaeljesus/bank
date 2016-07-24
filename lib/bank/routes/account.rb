require 'bank/models/account'

module Bank
  module Routes
    class Account < Base
      before do
        payload = request.env.values_at(:user).first
        user = Models::User.find_by(id: payload['id'])
        return halt 401 if user.nil?
      end

      create = -> do
        begin
          account = Models::Account.open(@payload)
          status 201
          json = account.to_json
        rescue Mongoid::Errors::Validations => e
          status 442
          json = {errors: e.summary}.to_json
        end
      end

      deposit = -> do
        Models::Account.deposit(params['id'], @payload['amount'])
        json = {deposited: true}.to_json
      end

      withdraw = -> do
        Models::Account.withdraw(params['id'], @payload['amount'])
        json = {withdrawn: true}.to_json
      end

      transfer = -> do
        Models::Account.transfer(params['id'], @payload['to'], @payload['amount'])
        json = {transfered: true}.to_json
      end

      post '/v1/accounts', &create
      post '/v1/accounts/:id/deposit', &deposit
      post '/v1/accounts/:id/withdraw', &withdraw
      post '/v1/accounts/:id/transfer', &transfer
    end
  end
end
