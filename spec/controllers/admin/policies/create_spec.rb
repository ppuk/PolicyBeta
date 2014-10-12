require 'rails_helper'

describe Admin::PoliciesController, type: :controller do
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
    let(:policy_attributes) do
      {
        title: 'title',
        description: 'description',
        category_id: '1'
      }
    end

    let(:send_action) { post :create, policy: policy_attributes }
    let(:policy) { build_stubbed(:policy) }

    before(:each) do
      allow(Policy).to receive(:new).and_return(policy)
    end

    context 'with an admin user' do
      before(:each) do
        sign_in_as admin
      end

      context 'on success' do
        before(:each) do
          allow(policy).to receive(:save).and_return(true)
        end

        it 'should redirect to the show page for the policy' do
          send_action
          expect(response).to redirect_to(admin_policy_path(policy))
        end

        it 'should assign the policy to the admin user' do
          expect(policy).to receive(:submitter=).with(admin)
          send_action
        end

        it 'should save the policy' do
          expect(policy).to receive(:save).and_return(true)
          send_action
        end

        it 'should assign the params' do
          expect(Policy).to receive(:new).with(policy_attributes).and_return(policy)
          send_action
        end
      end

      context 'on failure' do
        before(:each) do
          allow(policy).to receive(:save).and_return(false)
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

