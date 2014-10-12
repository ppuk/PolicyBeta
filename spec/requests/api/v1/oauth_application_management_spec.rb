require 'rails_helper'

describe 'Access to the application management interface', type: :request, tag: :api, vcr: true do

  describe 'GET /api/v1/oauth/applications' do
    context "with a user" do
      let(:user) { create(:user) }

      before(:each) do
        post '/session', session: { email: user.email, password: 'password' }
        get '/api/v1/oauth/applications'
      end

      it 'should render forbidden' do
        expect(response.status).to eql(403)
      end
    end


    context 'with an admin' do
      let(:user) { create(:admin) }

      before(:each) do
        post '/session', session: { email: user.email, password: 'password' }
        get '/api/v1/oauth/applications'
      end

      it 'should be success' do
        expect(response).to be_success
      end
    end
  end

end
