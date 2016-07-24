describe Bank::Routes::User do
  let(:user) { Bank::Models::User.new({id: '123b', email: 'foo@mail.com'}) }
  let(:token) { Bank::Support::Token.encode(user) }

  before do
    allow(Bank::Models::User).to receive(:find_by).and_return(user)
  end

  describe 'POST create' do
    context 'with valid params' do
      let(:params) { { name: 'Foo', user_id: '123b' } }
      let(:account) { Bank::Models::Account.new(params) }

      before do
        allow(Bank::Models::Account).to receive(:open).and_return(account)
      end

      it 'has a created account json' do
        header 'Authorization', "Bearer #{token}"
        post '/v1/accounts', params.to_json, provides: 'json'
        body = JSON.parse last_response.body
        expect(last_response.status).to eq 201
        expect(body['name']).to eq 'Foo'
      end
    end

    context 'with invalid params' do
      let(:without_name) { { password: '123456' } }

      it 'validates presence of name attribute' do
        header 'Authorization', "Bearer #{token}"
        post '/v1/accounts', without_name.to_json, provides: 'json'
        body = JSON.parse last_response.body
        expect(body['errors']).to eq "The following errors were found: Name can't be blank"
        expect(last_response.status).to eq 442
      end
    end
  end
end
