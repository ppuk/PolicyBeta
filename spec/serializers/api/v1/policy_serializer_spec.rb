require 'rails_helper'

describe Api::V1::PolicySerializer, tag: :api do
  let(:scope) { double current_user: user }
  let(:subject) { described_class.new(policy, scope: scope) }

  let(:user) { build_stubbed(:user) }
  let(:policy) { build_stubbed(:policy, submitter: user) }

  describe '.to_json' do
    it 'should render correctly' do
      expect(subject.as_json).to eql({
        policy: policy_serialized_hash(policy)
      })
    end
  end
end



