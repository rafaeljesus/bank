module Bank
  module Models
    class Account
      include Mongoid::Document
      include Mongoid::Timestamps

      field :name, type: String
      field :balance, type: Float, default: 0.00
      belongs_to :user

      validates_presence_of :balance, :name

      def initialize(name, balance = 0.00)
        @name, @balance = name, balance
      end

      def self.open(params)
        self.create!(
          name: params[:name],
          user_id: params[:user_id],
        )
      end

      def self.transfer(from, to, amount)
        return if amount <= 0
        # fetch account by from id
        # fetch account by to id
        # deposit amount for to
        # withdraw amount for from
        # save both accounts
      end

      def deposit(amount)
        return if amount <= 0
        @balance += amount
        # save account
      end

      def withdraw(amount)
        return if amount <= 0
        @balance -= amount
        # save account
      end
    end
  end
end
