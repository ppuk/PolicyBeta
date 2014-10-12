require 'rails_helper'

describe Admin::UsersController, type: :controller do

  describe '#destroy' do
    let(:user) { build_stubbed(:user, id: 1) }
    let(:send_action) { delete :destroy, id: 1 }

    before(:each) do
      allow(User).to receive(:find).and_return(user)
      allow(user).to receive(:decorate).and_return(user)
      allow(user).to receive(:destroy).and_return(true)
    end

    it_behaves_like 'admin restricted action' do
      let(:send_action) { delete :destroy, id: 1 }
    end

    context 'with an admin user' do
      let(:admin) { build_stubbed(:admin) }

      before(:each) do
        sign_in_as admin
      end

      it 'should redirect to the index page' do
        send_action
        expect(response).to redirect_to(admin_users_path)
      end

      it 'should try to destroy the user' do
        expect(user).to receive(:destroy)
        send_action
      end

      it 'should get the correct user' do
        expect(User).to receive(:find).with('1').and_return(user)
        send_action
      end

      context 'succesful destroy' do
        before(:each) do
          allow(user).to receive(:destroy).and_return(true)
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:success]).to eql('User deleted')
        end
      end

      context 'unsuccesful destroy' do
        before(:each) do
          allow(user).to receive(:destroy).and_return(false)
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:danger]).to eql('User not deleted')
        end
      end
    end
  end

end



