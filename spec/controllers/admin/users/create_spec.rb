require 'rails_helper'

describe Admin::UsersController, type: :controller do
  let!(:admin) { build_stubbed(:admin) }

  describe '#new' do
    let(:send_action) { get :new }

    it_behaves_like 'admin restricted action' do
      let(:send_action) { get :new }
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

      it 'should render the new page' do
        send_action
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#create' do
    let(:send_action) { post :create, user: { email: 'test@example.com' } }
    let(:user) { build_stubbed(:user) }

    before(:each) do
      allow(User).to receive(:new).and_return(user)
    end

    context 'with an admin user' do
      before(:each) do
        sign_in_as admin
      end

      context 'on success' do
        before(:each) do
          allow(user).to receive(:save).and_return(true)
        end

        it 'should redirect to the show page for the user' do
          send_action
          expect(response).to redirect_to(admin_user_path(user))
        end

        it 'should save the user' do
          expect(user).to receive(:save).and_return(true)
          send_action
        end

        it 'should assign the params' do
          expect(User).to receive(:new).with('email' => 'test@example.com').and_return(user)
          send_action
        end
      end

      context 'on failure' do
        before(:each) do
          allow(user).to receive(:save).and_return(false)
        end

        it 'should render the new page' do
          send_action
          expect(response).to be_success
          expect(response).to render_template(:new)
        end
      end
    end
  end

end
