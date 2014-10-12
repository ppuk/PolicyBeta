require 'rails_helper'

describe Admin::UsersController, type: :controller do

  describe '#send_password_reset' do
    let(:user) { build_stubbed(:user, id: 1) }
    let(:send_action) { post :send_password_reset, id: 1 }

    before(:each) do
      allow(User).to receive(:find).and_return(user)
      allow(user).to receive(:decorate).and_return(user)
    end

    it_behaves_like 'admin restricted action' do
      let(:send_action) { post :send_password_reset, id: 1 }
    end

    context 'with an admin user' do
      let(:admin) { build_stubbed(:admin) }

      before(:each) do
        sign_in_as admin
      end

      context 'with a user with a confirmed email address' do
        let(:mailer) { double }

        before(:each) do
          allow(user).to receive(:email_confirmed?).and_return(true)
          allow(user).to receive(:forgot_password!)

          allow(UserMailer).to receive(:change_password).and_return(mailer)
          allow(mailer).to receive(:deliver)
        end

        it 'should redirect to the show page' do
          send_action
          expect(response).to redirect_to(admin_user_path(user))
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:success]).to eql('Password reset sent')
        end

        it 'should send a password reset email' do
          expect(UserMailer).to receive(:change_password).with(user).and_return(mailer)
          expect(mailer).to receive(:deliver)
          send_action
        end

        it 'should get the correct user' do
          expect(User).to receive(:find).with('1').and_return(user)
          send_action
        end
      end

      context 'with a user without a confirmed email address' do
        let(:mailer) { double }

        before(:each) do
          allow(user).to receive(:email_confirmed?).and_return(false)
        end

        it 'should redirect to the show page' do
          send_action
          expect(response).to redirect_to(admin_user_path(user))
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:danger]).to eql('Users email has not been confirmed, so we cannot send emails to this address. Please confirm the users email address first.')
        end

        it 'should not send a password reset email' do
          expect(UserMailer).not_to receive(:change_password)
          send_action
        end

        it 'should get the correct user' do
          expect(User).to receive(:find).with('1').and_return(user)
          send_action
        end
      end

    end
  end

end




