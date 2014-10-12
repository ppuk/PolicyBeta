require 'rails_helper'

describe Api::V1::ProfileSerializer, tag: :api do
  let(:subject) { described_class.new(profile) }

  let(:profile) do
    build(
      :user,
      id: 5,
      role: role,
      email: 'test@example.com',
      username: 'username'
    )
  end

  describe '.to_json' do
    context 'not admin' do
      let(:role) { 'user' }

      it 'should render correctly' do
        expect(subject.as_json).to eql({
          profile: profile_serialized_hash(profile)
        })
      end
    end

    context 'admin' do
      let(:role) { 'admin' }

      it 'should render correctly' do
        expect(subject.as_json).to eql({
          profile: profile_serialized_hash(profile)
        })
      end
    end
  end
end

