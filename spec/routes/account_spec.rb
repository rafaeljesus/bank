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

    # context 'with invalid params' do
    #   let(:without_email) { { password: '123456' } }
    #   let(:without_password) { { email: 'foo@mail.com' } }
    #
    #   it 'validates presence of email attribute' do
    #     post '/v1/users', without_email.to_json, provides: 'json'
    #     body = JSON.parse last_response.body
    #     expect(body['errors']).to eq "The following errors were found: Email can't be blank"
    #   end
    #
    #   it 'validates presence of password attribute' do
    #     post '/v1/users', without_password.to_json, provides: 'json'
    #     body = JSON.parse last_response.body
    #     expect(body['errors']).to eq "The following errors were found: Password can't be blank"
    #   end
    # end
  end
end
