describe Bank::Routes::User do
  describe 'POST create' do
    context 'with valid params' do
      let(:user) { Bank::Models::User.new({id: '123456b'}) }
      let(:params) { { email: 'foo@mail.com', password: '123456' } }

      before do
        allow(Bank::Models::User).to receive(:create!).and_return(user)
      end

      it 'has a created id json' do
        post '/v1/users', params.to_json, provides: 'json'
        body = JSON.parse last_response.body
        expect(body['id']).to eq '123456b'
      end
    end

    context 'with invalid params' do
      let(:without_email) { { password: '123456' } }
      let(:without_password) { { email: 'foo@mail.com' } }

      it 'validates presence of email attribute' do
        post '/v1/users', without_email.to_json, provides: 'json'
        body = JSON.parse last_response.body
        expect(body['errors']).to eq "The following errors were found: Email can't be blank"
      end

      it 'validates presence of password attribute' do
        post '/v1/users', without_password.to_json, provides: 'json'
        body = JSON.parse last_response.body
        expect(body['errors']).to eq "The following errors were found: Password can't be blank"
      end
    end
  end
end
