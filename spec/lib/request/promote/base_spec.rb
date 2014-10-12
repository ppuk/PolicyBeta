require 'rails_helper'

describe Request::Promote::Base do

  let(:admin) { build_stubbed(:admin) }
  subject { described_class.new(policy, user) }

  before(:each) do
    allow(subject).to receive(:admins).and_return([admin])
  end

  describe 'initializing' do
    let(:user) { build_stubbed(:user) }
    let(:policy) { build_stubbed(:policy, state: 'suggestion', promotion_state: 'waiting') }

    it 'should set the user' do
      expect(subject.user).to eql(user)
    end

    it 'should set the policy' do
      expect(subject.policy).to eql(policy)
    end
  end


  describe 'with a user' do
    let(:user) { policy.submitter }

    before(:each) do
      allow(policy).to receive(:update_attribute).and_return(true)
      SendPolicyMail.stub(:perform_async)
    end


    describe 'requesting promotion' do
      let(:policy) { build_stubbed(:policy, state: 'suggestion', promotion_state: 'waiting') }

      it 'should transition from waiting to user_requested' do
        expect(policy).to receive(:update_attribute).with(:promotion_state, :user_requested).and_return(true)
        subject.request
      end


      it 'should email the admins' do
        expect(SendPolicyMail).to receive(:perform_async).with(:promotion_request, policy.id, admin.id, user.id)
        subject.request
      end
    end

    describe 'approving promotion' do
      let(:policy) { build_stubbed(:policy, state: 'suggestion', promotion_state: 'admin_requested') }

      it 'should transition from requested to approved to waiting' do
        allow(subject).to receive(:promote_policy!)

        expect(policy).to receive(:update_attribute).with(:promotion_state, :waiting).and_return(true)
        subject.approve
      end

      it 'should transition to next state' do
        allow(subject).to receive(:update_state)

        expect(policy).to receive(:update_attribute).with(:state, 'proposition').and_return(true)
        subject.approve
      end

      it 'should email the admins' do
        expect(SendPolicyMail).to receive(:perform_async).with(:promotion_accepted, policy.id, admin.id, user.id)
        subject.approve
      end
    end

    describe 'decline promotion' do
      let(:policy) { build_stubbed(:policy, state: 'suggestion', promotion_state: 'admin_requested') }

      it 'should transition from requested to waiting' do
        expect(policy).to receive(:update_attribute).with(:promotion_state, :waiting).and_return(true)
        subject.decline
      end

      it 'should email the admins' do
        expect(SendPolicyMail).to receive(:perform_async).with(:promotion_declined_by_user, policy.id, admin.id, user.id)
        subject.decline
      end
    end
  end


  describe 'with an admin user' do
    let(:user) { admin }

    before(:each) do
      allow(policy).to receive(:update_attribute).and_return(true)
      allow(SendPolicyMail).to receive(:perform_async)
    end

    describe 'requesting promotion' do
      let(:policy) { build_stubbed(:policy, state: 'suggestion', promotion_state: 'waiting') }

      it 'should transition from waiting to requested' do
        expect(policy).to receive(:update_attribute).with(:promotion_state, :admin_requested).and_return(true)
        subject.request
      end


      it 'should email the user' do
        expect(SendPolicyMail).to receive(:perform_async).with(:promotion_request, policy.id, policy.submitter_id, user.id)
        subject.request
      end
    end


    describe 'approving promotion' do
      let(:policy) { build_stubbed(:policy, state: 'suggestion', promotion_state: 'user_requested') }

      it 'should transition from requested to approved to waiting' do
        allow(subject).to receive(:promote_policy!)

        expect(policy).to receive(:update_attribute).with(:promotion_state, :waiting).and_return(true)
        subject.approve
      end

      it 'should transition to next state' do
        allow(subject).to receive(:update_state)

        expect(policy).to receive(:update_attribute).with(:state, 'proposition').and_return(true)
        subject.approve
      end

      it 'should email the user' do
        expect(SendPolicyMail).to receive(:perform_async).with(:promotion_accepted, policy.id, policy.submitter_id, user.id)
        subject.approve
      end
    end


    describe 'decline promotion' do
      let(:policy) { build_stubbed(:policy, state: 'suggestion', promotion_state: 'user_requested') }

      it 'should transition from requested to waiting' do
        expect(policy).to receive(:update_attribute).with(:promotion_state, :waiting).and_return(true)
        subject.decline
      end

      it 'should email the user' do
        expect(SendPolicyMail).to receive(:perform_async).with(:promotion_declined_by_admin, policy.id, policy.submitter_id, user.id)
        subject.decline
      end
    end
  end

end
