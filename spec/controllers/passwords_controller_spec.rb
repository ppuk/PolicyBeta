require 'rails_helper'

describe PasswordsController, type: :controller do

  describe 'url_after_update' do
    let(:user) { double(id: 1) }
    let(:event) { double }
    let(:subject) { controller }

    before(:each) do
      allow(subject).to receive(:current_user).and_return(user)
    end

    it 'should log the user event' do
      expect(Service::Event::User).to receive(:new).with(user).and_return(event)
      expect(event).to receive(:password_reset).once
      subject.send(:url_after_update)
    end

    it 'should return the correct url' do
      url = '/'
      expect(subject.send(:url_after_update)).to eql(url)
    end
  end

  describe 'deliver_email' do
    let(:user) { build_stubbed(:user) }
    let(:mailer) { double }
    let(:subject) { described_class.new }

    it 'should use the correct mailer' do
      expect(mailer).to receive(:deliver).and_return(true)
      expect(UserMailer).to receive(:change_password).with(user.id).and_return(mailer)
      subject.send(:deliver_email, user)
    end
  end

end
