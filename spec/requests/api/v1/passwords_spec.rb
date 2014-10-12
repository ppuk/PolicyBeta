require 'rails_helper'

describe 'Passwords', type: :request, vcr: true, tag: :api do

  describe 'POST create' do
    let(:user) { create(:user, :with_email) }
    let(:send_action) { post("/api/v1/passwords", email: email) }

    context 'with a valid email' do
      let(:email) { user.email }

      it 'should render success' do
        send_action
        expect(response.status).to eql(200)
      end

      it 'should send the password reset email' do
        expect {
          send_action
        }.to change(ActionMailer::Base::deliveries, :count).by(1)

        expect(ActionMailer::Base::deliveries.first.subject).to eql('Change your password')
      end
    end

    context 'with an invalid email' do
      let(:email) { 'invalid' }

      it 'should not send a password reset email' do
        expect {
          send_action
        }.not_to change(ActionMailer::Base::deliveries, :count)
      end

      it 'should render 404' do
        send_action
        expect(response.status).to eql(404)
      end
    end
  end

end

