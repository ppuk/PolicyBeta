require 'rails_helper'

describe Service::Policy::Accept do
  subject { described_class.new(policy: policy) }
  let(:policy) { build_stubbed(:policy) }
  let(:new_policy) { build_stubbed(:policy) }

  describe 'processing' do
    before(:each) do
      allow(new_policy).to receive(:save!).and_return(true)
      allow(policy).to receive(:dup).and_return(new_policy)
      allow(policy).to receive(:update_attribute)
      allow(SendPolicyMail).to receive(:perform_async)
    end

    it 'should duplicate the policy' do
      expect(policy).to receive(:dup).and_return(new_policy)
      expect(new_policy).to receive(:save!)
      subject.process
    end


    it 'should email the user' do
      expect(SendPolicyMail).to receive(:perform_async).with(:policy_accepted, new_policy.id)
      subject.process
    end

    it 'should set the existing policy to "passed"' do
      expect(policy).to receive(:update_attribute).with(:state, 'passed')
      subject.process
    end
  end

end
