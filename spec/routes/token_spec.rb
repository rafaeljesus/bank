describe Bank::Routes::Token do
  describe 'POST create' do
    context 'with valid params' do
      let(:user) { Bank::Models::User.new({id: '123456b'}) }
      let(:token) { 'token_hash' }
      let(:params) { { email: 'foo@mail.com', password: '123456' } }

      before do
        allow(Bank::Models::User).to receive(:find_by).and_return(user)
        allow(Bank::Support::Token).to receive(:encode).with(user).and_return(token)
      end

      it 'has a generated token json' do
        post '/v1/token', params.to_json, provides: 'json'
        body = JSON.parse last_response.body
        expect(body['token']).to eq token
      end
    end

    context 'with invalid params' do
      let(:without_email) { { password: '123456' } }
      let(:without_password) { { email: 'foo@mail.com' } }

      it 'validates presence of email attribute' do
        post '/v1/token', without_email.to_json, provides: 'json'
        expect(last_response.status).to eq 401
      end

      it 'validates presence of password attribute' do
        post '/v1/token', without_password.to_json, provides: 'json'
        expect(last_response.status).to eq 401
      end
    end
  end
end
