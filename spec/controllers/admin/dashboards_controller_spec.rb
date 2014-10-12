require 'rails_helper'

describe Admin::DashboardsController, type: :controller do

  describe 'GET show' do
    it_behaves_like 'admin restricted action' do
      let(:send_action) { get :show }
    end

    context 'with an admin user' do
      let(:send_action) { get :show }
      let(:admin) { build_stubbed(:admin) }

      before(:each) do
        sign_in_as admin
      end

      it 'should render succesfully' do
        send_action
        expect(response).to be_success
      end

      it 'should render the show template' do
        send_action
        expect(response).to render_template('show')
      end
    end

  end

end
