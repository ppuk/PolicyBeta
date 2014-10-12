require 'rails_helper'

describe Service::User::Confirm do
  let(:token) { SecureRandom.hex(20) }
  let(:email_hash) { 'EMAIL HASH' }
  let(:user) { build_stubbed(:user, email_confirmation_token: token) }

  describe '.perform' do
    subject { described_class.new({id: 1, email_hash: email_hash, token: token}) }

    before(:each) do
      allow(User).
        to receive_message_chain(:unconfirmed_email, :find).
        and_return(user)
    end

    context 'with a confirmed user' do
      before(:each) do
        allow(User).
          to receive_message_chain(:unconfirmed_email, :find).
          and_raise(ActiveRecord::RecordNotFound)
      end

      it 'should raise a RecordNotFound exception' do
        expect {
          subject.perform
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'with an invalid token' do
      let(:token) { 'INVALID TOKEN' }

      it 'should return false' do
        expect(subject.perform).to be_falsey
      end

      it 'should not confirm the email' do
        expect(user).to_not receive(:confirm_email!)
      end
    end

    context 'with an invalid hash' do
      before(:each) do
        allow(user).to receive(:hash_matches?).and_return(false)
      end

      it 'should return false' do
        expect(subject.perform).to be_falsey
      end

      it 'should not confirm the email' do
        expect(user).to_not receive(:confirm_email!)
      end
    end

    context 'with a valid user and tokens' do
      let(:event) { double }

      before(:each) do
        allow(user).to receive(:confirm_email!).and_return(true)
        allow(user).to receive(:hash_matches?).and_return(true)
      end

      it 'should return true' do
        expect(user).to receive(:confirm_email!).and_return(true)
        expect(subject.perform).to be_truthy
      end

      it 'should increment the stats count' do
        expect(Service::Event::User).to receive(:new).
          with(user).
          and_return(event)

        expect(event).to receive(:email_confirmed).and_return(true)
        subject.perform
      end
    end

  end

end
