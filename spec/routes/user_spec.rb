describe Bank::Routes::User do
  describe 'POST create' do
    context 'with valid params' do
      let(:params) { attributes_for(:user) }

      it 'has a created id json' do
        post '/v1/users', params.to_json, provides: 'json'
        expect(response_body_as_json['id']).not_to eq nil
      end
    end

    context 'with invalid params' do
      let(:without_email) { attributes_for(:user, email: nil) }
      let(:without_password) { attributes_for(:user, password: nil) }

      it 'validates presence of email attribute' do
        post '/v1/users', without_email.to_json, provides: 'json'
        expect(response_body_as_json['errors']['email']).not_to eq nil
      end

      it 'validates presence of password attribute' do
        post '/v1/users', without_password.to_json, provides: 'json'
        expect(response_body_as_json['errors']['password']).not_to eq nil
      end
    end
  end
end
