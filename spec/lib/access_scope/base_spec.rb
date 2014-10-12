require 'rails_helper'

describe AccessScope::Base do
  describe 'as an admin' do
    let(:user) { build_stubbed(:admin) }

    it 'should use the admin scopes' do
      expect(AccessScope::Scope::Admin).to receive(:new)
      described_class.new(user)
    end
  end

  describe 'as a user' do
    let(:user) { build_stubbed(:user) }

    it 'should use the user scopes' do
      expect(AccessScope::Scope::User).to receive(:new)
      described_class.new(user)
    end
  end

  describe 'with an invalid role' do
    let(:user) { build_stubbed(:user, role: 'invalid') }

    it 'should use the base scopes' do
      expect(AccessScope::Scope::Base).to receive(:new)
      described_class.new(user)
    end
  end
end
