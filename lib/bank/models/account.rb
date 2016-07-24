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
        puts "Creating a account with #{params}"

        self.create!(
          name: params['name'],
          user: params['user_id']
        )
      end

      def self.deposit(id, amount)
        puts "Depositing #{amount} on account #{id}"

        if amount <= 0
          return puts 'Deposit failed! Amount must be greater than 0.00'
        end

        account = self.find_by(id: id)
        account.balance = (account.balance += amount).round(2)
        account.save!
      end

      def self.withdraw(id, amount)
        puts "Withdrawing #{amount} on account #{id}"

        if amount <= 0
          return puts 'Withdraw failed! Amount must be greater than 0.00'
        end

        account = self.find_by(id: id)
        account.balance = (account.balance -= amount).round(2)
        account.save!
      end

      def self.transfer(from, to, amount)
        puts "Transfering #{amount} from account #{from} to account #{to}"

        if amount <= 0
          return puts 'Transfer failed! Amount must be greater than 0.00'
        end

        self.deposit(to, amount)
        self.withdraw(from, amount)
      end
    end
  end
end
