require 'rails_helper'

describe Service::Event::Mail do
  subject { described_class.new }

  let(:send_action) { subject.create }

  context '#delivered_email' do
    let(:mail) { { stats_key: 'test_email' } }

    it 'should instantiate a new instance with the kind from the mail object' do
      expect(described_class).to receive(:new).once.with(kind: 'test_email').and_return(nil)
      described_class.delivered_email(mail)
    end
  end

  context '.create' do
    it 'should increment metrics' do
      expect(subject).to receive(:log).with('mail').and_return(true)
      send_action
    end
  end

  context '.create with specific class' do
    subject { described_class.new(kind: 'welcome_message') }

    it 'should increment metrics' do
      expect(subject).to receive(:log).with('mail').and_return(true)
      expect(subject).to receive(:log).with('mail.welcome_message').and_return(true)
      send_action
    end
  end
end

