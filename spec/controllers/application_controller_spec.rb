require 'rails_helper'

describe ApplicationController, type: :controller do
  describe 'current_user' do
    subject { controller.current_user }
    let(:user) { build_stubbed(:user) }

    before(:each) do
      sign_in_as user
    end

    it 'should decorate the current user object' do
      expect(subject).to be_a(UserDecorator)
    end
  end
end
