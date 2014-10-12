require 'rails_helper'

describe Admin::UsersController, type: :controller do
  let(:user) { build_stubbed(:user, id: 1) }
  let(:admin) { build_stubbed(:admin) }

  before(:each) do
    allow(User).to receive(:find).and_return(user)
    allow(user).to receive(:decorate).and_return(user)
  end

  describe '#edit' do
    let(:send_action) { get :edit, id: 1 }

    it_behaves_like 'admin restricted action' do
      let(:send_action) { get :edit, id: 1 }
    end

    context 'with an admin user' do
      let(:admin) { build_stubbed(:admin) }

      before(:each) do
        sign_in_as admin
      end

      it 'should render successfully' do
        send_action
        expect(response).to be_success
      end

      it 'should render the edit page' do
        send_action
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#update' do
    let(:send_action) { put :update, id: 1, user: { email: 'test@example.com' } }

    it_behaves_like 'admin restricted action' do
      let(:send_action) { put :update, id: 1, user: { email: 'test@example.com' } }
    end

    context 'with an admin user' do
      before(:each) do
        sign_in_as admin
      end

      context 'on success' do
        before(:each) do
          allow(user).to receive(:update_attributes).and_return(true)
        end

        it 'should redirect to the show page for the user' do
          send_action
          expect(response).to redirect_to(admin_user_path(user))
        end

        it 'should save the user' do
          expect(user).to receive(:update_attributes).with('email' => 'test@example.com').and_return(true)
          send_action
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:success]).to eql('User updated')
        end

        it 'should get the correct user' do
          expect(User).to receive(:find).with('1').and_return(user)
          send_action
        end
      end

      context 'on failure' do
        before(:each) do
          allow(user).to receive(:update_attributes).and_return(false)
        end

        it 'should render the edit page' do
          send_action
          expect(response).to be_success
          expect(response).to render_template(:edit)
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:danger]).to eql('User not updated')
        end

        it 'should get the correct user' do
          expect(User).to receive(:find).with('1').and_return(user)
          send_action
        end
      end
    end
  end

end

