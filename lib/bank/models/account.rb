module Bank
  module Models
    class Account
      include Mongoid::Document
      include Mongoid::Timestamps

      field :name, type: String
      field :balance, type: Float, default: 0.00

      belongs_to :user, class_name: 'Bank::Models::User'

      validates_presence_of :name, :balance

      def self.open(params)
        self.create!(
          name: params['name'],
          user: params['user_id']
        )
      end

      def self.deposit(id, amount)
        return if amount <= 0
        account = self.find_by(id: id)
        account.balance = (account.balance += amount).round(2)
        account.save!
      end

      def self.withdraw(id, amount)
        return if amount <= 0
        account = self.find_by(id: id)
        account.balance = (account.balance -= amount).round(2)
        account.save!
      end

      def self.transfer(from, to, amount)
        return if amount <= 0
        self.deposit(to, amount)
        self.withdraw(from, amount)
      end
    end
  end
end
