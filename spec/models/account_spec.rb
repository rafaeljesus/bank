describe Bank::Models::Account do
  let(:params) { { 'name' => 'Foo', 'user_id' => '123b', 'balance' => 9.99 } }

  after do
    described_class.delete_all
  end

  describe '#open' do
    context 'with valid params' do
      it 'opens a new account' do
        account = described_class.open(params)
        expect(account.id).not_to eq nil
      end
    end

    context 'with invalid params' do
      let(:without_name) { { user_id: '123b' } }
      let(:without_user_id) { { name: 'Foo' } }

      it 'validates presence of name attribute' do
        expect{described_class.open(without_name)}.to raise_error Mongoid::Errors::Validations
      end

      it 'validates presence of user_id attribute' do
        expect{described_class.open(without_user_id)}.to raise_error Mongoid::Errors::Validations
      end
    end
  end

  describe '#deposit' do
    context 'with valid params' do
      let(:account) { Bank::Models::Account.open(params) }

      it 'deposit into account' do
        deposited = Bank::Models::Account.deposit(account.id, 9.99)
        expect(deposited).to eq true
      end
    end

    context 'when amount <= 0' do
      it 'returns false' do
        deposited = Bank::Models::Account.deposit('123b', 0.00)
        expect(deposited).to eq false
      end
    end
  end

  describe '#withdraw' do
    context 'with valid params' do
      let(:account) { Bank::Models::Account.open(params) }

      it 'withdraw from account' do
        withdrawn = Bank::Models::Account.withdraw(account.id, 9.99)
        expect(withdrawn).to eq true
      end
    end

    context 'when amount <= 0' do
      it 'returns false' do
        withdrawn = Bank::Models::Account.withdraw('123b', 0.00)
        expect(withdrawn).to eq false
      end
    end
  end

  describe '#transfer' do
    context 'with valid params' do
      let(:params_to) { { 'name' => 'Foo', 'user_id' => '123c', 'balance' => 0.00 } }
      let(:from) { Bank::Models::Account.open(params) }
      let(:to) { Bank::Models::Account.open(params_to) }

      it 'transfer from one account to another account' do
        transfered = Bank::Models::Account.transfer(from.id, to.id, 9.99)
        expect(transfered).to eq true
      end
    end

    context 'when amount <= 0' do
      it 'returns false' do
        transfered = Bank::Models::Account.transfer('123b', '123c', 0.00)
        expect(transfered).to eq false
      end
    end
  end
end
