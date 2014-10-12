require 'rails_helper'

describe UserMailer, :type => :mailer do

  describe '.change_password' do
    let(:confirmation_token) { 'TEST_CONFIRMATION_TOKEN' }
    let(:user) { build_stubbed(:user, :with_email, confirmation_token: confirmation_token) }
    let(:mail) { UserMailer.change_password(user.id) }

    before(:each) do
      allow(User).to receive(:find).with(user.id).and_return(user)
    end

    it "should have the correct subject" do
      expect(mail.subject).to eql('Change your password')
    end

    it "should send to the correct email address" do
      expect(mail.to).to eql([user.email])
    end

    it "should be from the correct email address" do
      expect(mail.from).to eql(['noreply@example.com'])
    end

    it "should include a link to the edit password action" do
      expect(mail.body.encoded).to include(
        edit_user_password_url(user, token: confirmation_token)
      )
    end
  end

  describe '.welcome' do
    let(:email_confirmation_token) { 'TEST_CONFIRMATION_TOKEN' }
    let(:email_hash_token) { 'HASH_TOKEN' }
    let(:user) { build_stubbed(:user, :with_email) }
    let(:mail) { UserMailer.welcome(user.id) }

    before(:each) do
      allow(user).to receive(:email_confirmation_token).and_return(email_confirmation_token)
      allow(user).to receive(:email_confirmation_url_token).and_return(email_hash_token)
      allow(User).to receive(:find).with(user.id).and_return(user)
    end

    it "should have the correct subject" do
      expect(mail.subject).to eql('Welcome')
    end

    it "should send to the correct email address" do
      expect(mail.to).to eql([user.email])
    end

    it "should be from the correct email address" do
      expect(mail.from).to eql(['noreply@example.com'])
    end
  end

end
