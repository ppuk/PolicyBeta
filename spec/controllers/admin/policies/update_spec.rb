require 'rails_helper'

describe Admin::PoliciesController, type: :controller do
  let(:policy) { build_stubbed(:policy, id: 1) }
  let(:admin) { build_stubbed(:admin) }

  before(:each) do
    allow(Policy).to receive(:find).and_return(policy)
    allow(policy).to receive(:decorate).and_return(policy)
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
    let(:send_action) { put :update, id: 1, policy: { title: 'test' } }

    it_behaves_like 'admin restricted action' do
      let(:send_action) { put :update, id: 1, policy: { title: 'test' } }
    end

    context 'with an admin user' do
      before(:each) do
        sign_in_as admin
      end

      context 'on success' do
        before(:each) do
          allow(policy).to receive(:update_attributes).and_return(true)
        end

        it 'should redirect to the show page for the policy' do
          send_action
          expect(response).to redirect_to(admin_policy_path(policy))
        end

        it 'should save the policy' do
          expect(policy).to receive(:update_attributes).with('title' => 'test').and_return(true)
          send_action
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:success]).to eql('Policy updated')
        end

        it 'should get the correct policy' do
          expect(Policy).to receive(:find).with('1').and_return(policy)
          send_action
        end
      end

      context 'on failure' do
        before(:each) do
          allow(policy).to receive(:update_attributes).and_return(false)
        end

        it 'should render the edit page' do
          send_action
          expect(response).to be_success
          expect(response).to render_template(:edit)
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:danger]).to eql('Policy not updated')
        end

        it 'should get the correct policy' do
          expect(Policy).to receive(:find).with('1').and_return(policy)
          send_action
        end
      end
    end
  end

end

