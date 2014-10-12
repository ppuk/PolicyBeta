require 'rails_helper'

describe Service::Event::User do
  let(:user) { build_stubbed(:user, id: 1) }
  subject { described_class.new(user) }

  context '.email_confirmed' do
    it 'should record the event' do
      expect(subject).to receive(:log).with('user.email_confirmed').and_return(nil)
      expect(subject).to receive(:log).with('user.email_confirmed.1').and_return(nil)

      subject.email_confirmed
    end
  end

  context '.signed_in' do
    it 'should record the event' do
      expect(subject).to receive(:log).with('user.login').and_return(nil)
      expect(subject).to receive(:log).with('user.login.1').and_return(nil)

      subject.signed_in
    end
  end

  context '.signed_up' do
    it 'should record the event' do
      expect(subject).to receive(:log).with('user.signup').and_return(nil)
      expect(subject).to receive(:log).with('user.signup.1').and_return(nil)

      subject.signed_up
    end
  end

  context '.password_reset' do
    it 'should record the event' do
      expect(subject).to receive(:log).with('user.password_reset').and_return(nil)
      expect(subject).to receive(:log).with('user.password_reset.1').and_return(nil)

      subject.password_reset
    end
  end

  context '.soft_deleted' do
    it 'should record the event' do
      expect(subject).to receive(:log).with('user.soft_delete').and_return(nil)
      expect(subject).to receive(:log).with('user.soft_delete.1').and_return(nil)

      subject.soft_deleted
    end
  end

end

