describe Bank::Routes::User do
  let(:id) { 1 }
  let(:user_params) { attributes_for(:user) }
  let(:user) { Bank::Entity::User.new({ id: 1 }.merge(user_params)) }
  let(:token) { Bank::Support::Token.encode(user) }

  before do
    allow(Bank::Entity::User).to receive(:find_by).and_return(user)
  end

  describe 'POST create' do
    let(:params) { attributes_for(:account, user_id: user.id) }

    context 'with valid params' do
      before do
        allow(Bank::Entity::Account).to receive(:open).and_return(true)
      end

      it 'has status 201' do
        header 'Authorization', "Bearer #{token}"
        post '/v1/accounts', params.to_json, provides: 'json'
        expect(last_response.status).to eq 201
      end
    end

    context 'with invalid params' do
      before do
        allow(Bank::Entity::Account).to receive(:open).and_return(false)
      end

      it 'has status 422' do
        header 'Authorization', "Bearer #{token}"
        post '/v1/accounts', params.to_json, provides: 'json'
        expect(last_response.status).to eq 442
      end
    end
  end

  describe 'POST deposit' do
    let(:params) { { amount: 9.99 } }

    context 'with valid params' do
      let(:account) { double('Account') }

      before do
        allow(Bank::Entity::Account).to receive(:find).with(id.to_s).and_return(account)
        allow(Bank::Entity::Account).to receive(:deposit).with(account, params[:amount]).and_return(true)
      end

      it 'has a deposited json response' do
        header 'Authorization', "Bearer #{token}"
        post "/v1/accounts/#{id}/deposit", params.to_json, provides: 'json'
        expect(response_body_as_json['deposited']).to eq true
      end
    end

    context 'with invalid params' do
      let(:account) { double('Account') }

      before do
        allow(Bank::Entity::Account).to receive(:find).with(id.to_s).and_return(account)
        allow(Bank::Entity::Account).to receive(:deposit).with(account, params[:amount]).and_return(false)
      end

      it 'has status 442' do
        header 'Authorization', "Bearer #{token}"
        post "/v1/accounts/#{id}/deposit", params.to_json, provides: 'json'
        expect(last_response.status).to eq 442
      end
    end

    context 'with not found account' do
      before do
        allow(Bank::Entity::Account).to receive(:find).with(id.to_s).and_return(nil)
      end

      it 'has status 404' do
        header 'Authorization', "Bearer #{token}"
        post "/v1/accounts/#{id}/deposit", params.to_json, provides: 'json'
        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'POST withdraw' do
    let(:params) { { amount: 9.99 } }

    context 'with valid params' do
      let(:account) { double('Account') }

      before do
        allow(Bank::Entity::Account).to receive(:find).with(id.to_s).and_return(account)
        allow(Bank::Entity::Account).to receive(:withdraw).with(account, params[:amount]).and_return(true)
      end

      it 'has a withdrawn json response' do
        header 'Authorization', "Bearer #{token}"
        post "/v1/accounts/#{id}/withdraw", params.to_json, provides: 'json'
        expect(response_body_as_json['withdrawn']).to eq true
      end
    end

    context 'with invalid params' do
      let(:account) { double('Account') }

      before do
        allow(Bank::Entity::Account).to receive(:find).with(id.to_s).and_return(account)
        allow(Bank::Entity::Account).to receive(:withdraw).with(account, params[:amount]).and_return(false)
      end

      it 'has status 442' do
        header 'Authorization', "Bearer #{token}"
        post "/v1/accounts/#{id}/withdraw", params.to_json, provides: 'json'
        expect(last_response.status).to eq 442
      end
    end

    context 'with not found account' do
      before do
        allow(Bank::Entity::Account).to receive(:find).with(id.to_s).and_return(nil)
      end

      it 'has status 404' do
        header 'Authorization', "Bearer #{token}"
        post "/v1/accounts/#{id}/withdraw", params.to_json, provides: 'json'
        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'POST transfer' do
    let(:recipient_id) { 2 }
    let(:account) { double('Account') }
    let(:recipient) { double('Recipient') }
    let(:params) { { recipient_id: recipient_id, amount: 9.99 } }

    context 'with valid params' do
      before do
        allow(Bank::Entity::Account).to receive(:find).with(id.to_s).and_return(account)
        allow(Bank::Entity::Account).to receive(:find).with(recipient_id).and_return(recipient)
        allow(Bank::Entity::Account).to receive(:transfer).with(account, recipient, params[:amount]).and_return(true)
      end

      it 'has a deposited json response' do
        header 'Authorization', "Bearer #{token}"
        post "/v1/accounts/#{id}/transfer", params.to_json, provides: 'json'
        expect(response_body_as_json['transfered']).to eq true
      end
    end

    context 'with invalid params' do
      before do
        allow(Bank::Entity::Account).to receive(:find).with(id.to_s).and_return(account)
        allow(Bank::Entity::Account).to receive(:find).with(recipient_id).and_return(recipient)
        allow(Bank::Entity::Account).to receive(:transfer).with(account, recipient, params[:amount]).and_return(false)
      end

      it 'has a status 442' do
        header 'Authorization', "Bearer #{token}"
        post "/v1/accounts/#{id}/transfer", params.to_json, provides: 'json'
        expect(last_response.status).to eq 442
      end
    end

    context 'with not found account' do
      before do
        allow(Bank::Entity::Account).to receive(:find).with(id.to_s).and_return(nil)
      end

      it 'has status 404' do
        header 'Authorization', "Bearer #{token}"
        post "/v1/accounts/#{id}/transfer", params.to_json, provides: 'json'
        expect(last_response.status).to eq 404
      end
    end

    context 'with not found recipient' do
      before do
        allow(Bank::Entity::Account).to receive(:find).with(id.to_s).and_return(account)
        allow(Bank::Entity::Account).to receive(:find).with(recipient_id).and_return(nil)
      end

      it 'has status 404' do
        header 'Authorization', "Bearer #{token}"
        post "/v1/accounts/#{id}/transfer", params.to_json, provides: 'json'
        expect(last_response.status).to eq 404
      end
    end
  end
end
