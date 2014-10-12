require 'rails_helper'

describe Service::User::Create do

  describe '.perform' do
    subject { described_class.new({email: 'test@example.com'}) }
    let(:user) { build_stubbed(:user, email: 'test@example.com') }
    let(:event) { double signed_up: true }
    let(:mailer) { double deliver: true }

    before(:each) do
      allow(User).to receive(:new).and_return(user)
      allow(Service::Event::User).to receive(:new).and_return(event)
      allow(UserMailer).to receive(:welcome).and_return(mailer)
    end

    context 'with valid params' do
      before(:each) do
        allow(user).to receive(:save).and_return(true)
      end

      it 'should return true' do
        expect(subject.perform).to be_truthy
      end

      it 'should log the creation event' do
        expect(event).to receive(:signed_up)
        subject.perform
      end

      it 'should send the welcome email' do
        expect(mailer).to receive(:deliver)
        subject.perform
      end

      it 'should set the user' do
        subject.perform
        expect(subject.user).to eql(user)
      end
    end

    context 'with invalid params' do
      before(:each) do
        allow(user).to receive(:save).and_return(false)
      end

      it 'should return false' do
        expect(subject.perform).to be_falsey
      end

      it 'should set the user' do
        subject.perform
        expect(subject.user).to eql(user)
      end
    end
  end

end

