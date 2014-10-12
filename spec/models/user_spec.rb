require 'rails_helper'

describe User, type: :model, vcr: true do
  describe "validations" do
    before(:each) { create(:user, :with_email) }

    it { is_expected.to validate_presence_of :username }
    it { is_expected.to validate_uniqueness_of :username }
    it { is_expected.to validate_uniqueness_of :email }
  end

  it_behaves_like 'email confirmable'

  describe 'defaults' do
    it 'should have a user role by default' do
      expect(User.new.role).to eql('user')
    end
  end
end

