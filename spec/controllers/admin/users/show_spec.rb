require 'rails_helper'

describe Admin::UsersController, type: :controller do

  describe '#show' do
    let(:user) { build_stubbed(:user, id: 1) }
    let(:send_action) { get :show, id: 1 }

    before(:each) do
      allow(User).to receive(:find).and_return(user)
      allow(user).to receive(:decorate).and_return(user)
    end

    it_behaves_like 'admin restricted action' do
      let(:send_action) { get :show, id: 1 }
    end

    context 'with an admin user' do
      let(:admin) { build_stubbed(:admin) }

      before(:each) do
        sign_in_as admin
      end

      it 'should render' do
        send_action
        expect(response).to be_success
      end

      it 'should render the show template' do
        send_action
        expect(response).to render_template(:show)
      end
    end
  end

end
