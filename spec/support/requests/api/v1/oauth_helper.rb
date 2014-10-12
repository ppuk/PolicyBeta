module Requests
  module Api
    module V1
      module OauthHelper
        def get_valid_token(user)
          oauth_client.password.get_token(user.email, 'password')
        end

        def oauth_client
          oauth2_app = create(:oauth_application)

          OAuth2::Client.new(oauth2_app.uid, oauth2_app.secret, {raise_errors: false, token_url: '/api/v1/oauth/token'}) do |b|
            b.request :url_encoded
            b.adapter :rack, Rails.application
          end
        end
      end
    end
  end
end
