require 'rails_helper'

describe Admin::PoliciesController, type: :controller do

  describe '#destroy' do
    let(:policy) { build_stubbed(:policy, id: 1) }
    let(:send_action) { delete :destroy, id: 1 }

    before(:each) do
      allow(Policy).to receive(:find).and_return(policy)
      allow(policy).to receive(:decorate).and_return(policy)
      allow(policy).to receive(:destroy).and_return(true)
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
        expect(response).to redirect_to(admin_policies_path)
      end

      it 'should try to destroy the policy' do
        expect(policy).to receive(:destroy)
        send_action
      end

      it 'should get the correct policy' do
        expect(Policy).to receive(:find).with('1').and_return(policy)
        send_action
      end

      context 'succesful destroy' do
        before(:each) do
          allow(policy).to receive(:destroy).and_return(true)
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:success]).to eql('Policy deleted')
        end
      end

      context 'unsuccesful destroy' do
        before(:each) do
          allow(policy).to receive(:destroy).and_return(false)
        end

        it 'should set the flash' do
          send_action
          expect(controller.flash[:danger]).to eql('Policy not deleted')
        end
      end
    end
  end

end



