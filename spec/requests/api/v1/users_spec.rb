require 'rails_helper'

describe 'Users', type: :request, vcr: true, tag: :api do

  describe 'POST create' do
    let(:send_action) { post("/api/v1/users", user: params) }

    context 'vith valid params' do
      let(:params) { attributes_for(:user, :with_email) }

      it 'should create the user' do
        expect {
          send_action
        }.to change(User, :count).by(1)
      end

      it 'should respond with the new user' do
        send_action
        expect(parsed_response).to eql(
          profile: profile_serialized_hash(User.last)
        )
      end

      it 'should render success' do
        send_action
        expect(response.status).to eql(200)
      end

      it 'should send the welcome email' do
        expect {
          send_action
        }.to change(ActionMailer::Base::deliveries, :count).by(1)

        expect(ActionMailer::Base::deliveries.first.subject).to eql('Welcome')
      end
    end


    context 'with valid params (but without an email address)' do
      let(:params) { attributes_for(:user) }

      it 'should create the user' do
        expect {
          send_action
        }.to change(User, :count).by(1)
      end

      it 'should respond with the new user' do
        send_action
        expect(parsed_response).to eql(
          profile: profile_serialized_hash(User.last)
        )
      end

      it 'should render success' do
        send_action
        expect(response.status).to eql(200)
      end

      it 'should not send the welcome email' do
        expect {
          send_action
        }.to_not change(ActionMailer::Base::deliveries, :count)
      end
    end

    context 'with invalid params' do
      let(:params) { { email: 'invalid' } }

      it 'should not create a new user' do
        expect {
          send_action
        }.not_to change(User, :count)
      end

      it 'should respond as unprocessable' do
        send_action
        expect(response.status).to eql(422)
      end

      it 'should render the errors' do
        send_action
        expect(parsed_response[:errors]).not_to be_empty
        expect(parsed_response[:errors]).to eql([
          { password: "blank" },
          { username: "blank"},
          { email: "invalid" }
        ])
      end

      it 'should send no emails' do
        expect {
          send_action
        }.not_to change(ActionMailer::Base::deliveries, :count)
      end
    end
  end

end
