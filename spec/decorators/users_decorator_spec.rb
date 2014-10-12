require 'rails_helper'

describe UserDecorator do
  describe '#logged_in_display_name' do
    let(:user) { build_stubbed(:user, :with_email) }
    subject { described_class.decorate(user).logged_in_display_name }

    it 'should return the username' do
      expect(subject).to eql(user.username)
    end
  end
end
