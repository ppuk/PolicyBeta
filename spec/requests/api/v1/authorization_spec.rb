require 'rails_helper'

describe 'Authorization', type: :request, tag: :api, vcr: true do
  let(:user) { create(:user) }
  let(:oauth2_app) { create(:oauth_application) }


  context 'with a valid client' do
    let(:client) do
      OAuth2::Client.new(oauth2_app.uid, oauth2_app.secret, token_url: '/api/v1/oauth/token') do |b|
        b.request :url_encoded
        b.adapter :rack, Rails.application
      end
    end


    context 'with valid login details' do
      let(:token) { client.password.get_token(user.email, 'password') }

      it 'should return an non-expired token' do
        expect(token).not_to be_expired
      end

      it 'should set refresh token' do
        expect(token.refresh_token).not_to be_nil
      end
    end

    context 'with invalid login details' do
      it 'should not allow access' do
        expect do
          client.password.get_token(user.email, 'invalid')
        end.to raise_error(OAuth2::Error)
      end
    end
  end


  context 'with an invalid client' do
    let(:client) do
      OAuth2::Client.new(oauth2_app.uid, 'invalid', token_url: '/api/v1/oauth/token') do |b|
        b.request :url_encoded
        b.adapter :rack, Rails.application
      end
    end

    it 'should not allow access' do
      expect do
        client.password.get_token(user.email, 'password')
      end.to raise_error(OAuth2::Error)
    end
  end


  context 'when logged in via the main site' do
    before(:each) do
      post '/session', session: { email: user.email, password: 'password' }
    end

    it 'should allow access to the api without a token' do
      get '/api/v1/profile'
      expect(response).to be_success
    end
  end

end
