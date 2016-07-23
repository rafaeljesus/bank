require 'bank/models/account'

module Bank
  module Routes
    class Account < Base
      create = -> do
      end

      open = -> do
      end

      deposit = -> do
      end

      withdraw = -> do
      end

      transfer = -> do
      end

      post '/v1/accounts', &create
      post '/v1/accounts/open', &open
      post '/v1/accounts/deposit', &deposit
      post '/v1/accounts/withdraw', &withdraw
      post '/v1/accounts/transfer', &transfer
    end
  end
end
