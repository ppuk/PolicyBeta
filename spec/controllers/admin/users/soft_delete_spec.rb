require 'rails_helper'

describe Admin::UsersController, type: :controller do

  describe '#soft_delete' do
    let(:user) { build_stubbed(:user, id: 1) }
    let(:deleter) { double(process: true) }
    let(:send_action) { delete :soft_delete, id: 1 }

    before(:each) do
      allow(User).to receive(:find).and_return(user)
      allow(user).to receive(:decorate).and_return(user)
      allow(Service::User::SoftDelete).to receive(:new).and_return(deleter)
    end

    it_behaves_like 'admin restricted action' do
      let(:send_action) { delete :soft_delete, id: 1 }
    end

    context 'with an admin user' do
      let(:admin) { build_stubbed(:admin) }

      before(:each) do
        sign_in_as admin
      end

      it 'should redirect to the user page' do
        send_action
        expect(response).to redirect_to(admin_user_path(user))
      end

      it 'should try to destroy the user' do
        expect(deleter).to receive(:process)
        send_action
      end

      it 'should get the correct user' do
        expect(User).to receive(:find).with('1').and_return(user)
        send_action
      end

      context 'succesful delete' do
        before(:each) do
          allow(deleter).to receive(:process).and_return(true)
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:success]).to eql('User anonymised')
        end
      end

      context 'unsuccesful destroy' do
        before(:each) do
          allow(deleter).to receive(:process).and_return(false)
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:danger]).to eql('User not anonymised')
        end
      end
    end
  end

end



