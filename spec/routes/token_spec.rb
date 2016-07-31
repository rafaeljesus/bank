describe Bank::Routes::Token do
  describe 'POST create' do
    context 'with valid params' do
      let(:user) { Bank::Entity::User.new({id: 1}) }
      let(:token) { 'token_hash' }
      let(:params) { attributes_for(:user) }

      before do
        allow(Bank::Entity::User).to receive(:find_by).and_return(user)
        allow(Bank::Support::Token).to receive(:encode).with(user).and_return(token)
      end

      it 'has a generated token json' do
        post '/v1/token', params.to_json, provides: 'json'
        expect(response_body_as_json['token']).to eq token
      end
    end

    context 'with invalid params' do
      let(:without_email) { attributes_for(:user, email: nil) }
      let(:without_password) { attributes_for(:user, password: nil) }

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
