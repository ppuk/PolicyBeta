require 'rails_helper'

describe Admin::UsersController, type: :controller do

  describe '#impersonate' do
    let(:user) { build_stubbed(:user, id: 1) }
    let(:send_action) { post :impersonate, id: 1 }

    before(:each) do
      allow(User).to receive(:find).and_return(user)
      allow(user).to receive(:decorate).and_return(user)
    end

    it_behaves_like 'admin restricted action' do
      let(:send_action) { post :impersonate, id: 1 }
    end

    context 'with an admin user' do
      let(:admin) { build_stubbed(:admin) }

      before(:each) do
        sign_in_as admin
      end

      it 'should redirect to the root page' do
        send_action
        expect(response).to redirect_to(root_path)
      end

      it 'should log in as the user' do
        send_action
        expect(controller.current_user.object).to eql(user)
      end

      it 'should get the correct user' do
        expect(User).to receive(:find).with('1').and_return(user)
        send_action
      end
    end
  end

end



