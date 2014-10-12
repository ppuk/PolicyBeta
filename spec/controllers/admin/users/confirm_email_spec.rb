require 'rails_helper'

describe Admin::UsersController, type: :controller do

  describe '#confirm_email' do
    let(:search_object) { double }
    let(:user) { build_stubbed(:user, id: 1) }
    let(:send_action) { put :confirm_email, id: 1 }

    before(:each) do
      allow(User).to receive(:find).and_return(user)
      allow(user).to receive(:decorate).and_return(user)
      allow(user).to receive(:confirm_email!)
    end

    it_behaves_like 'admin restricted action' do
      let(:send_action) { put :confirm_email, id: 1 }
    end

    context 'with an admin user' do
      let(:admin) { build_stubbed(:admin) }

      before(:each) do
        sign_in_as admin
      end

      it 'should redirect to the show page' do
        send_action
        expect(response).to redirect_to(admin_user_path(user))
      end

      it 'should confirm the users email' do
        expect(user).to receive(:confirm_email!).and_return(true)
        send_action
      end

      it 'should get the correct user' do
        expect(User).to receive(:find).with('1').and_return(user)
        send_action
      end
    end
  end

end


