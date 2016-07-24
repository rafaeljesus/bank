describe Bank::Models::Account do
  after do
    described_class.delete_all
  end

  describe '#open' do
    context 'with valid params' do
      let(:params) { { 'name' => 'Foo', 'user_id' => '123b' } }

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
end
