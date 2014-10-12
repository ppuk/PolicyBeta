require 'rails_helper'

describe Service::User::SoftDelete do

  describe '.perform' do
    let(:user) { build_stubbed(:user) }
    subject { described_class.new(user) }
    let(:event) { double soft_deleted: true }

    before(:each) do
      allow(user).to receive(:save).and_return(true)
      allow(Service::Event::User).to receive(:new).and_return(event)
    end

    it 'should return true' do
      expect(subject.perform).to be_truthy
    end

    it 'should log the deletion event' do
      expect(Service::Event::User).to receive(:new).with(user).and_return(event)
      expect(event).to receive(:soft_deleted)
      subject.perform
    end

    it 'should update the user' do
      subject.perform
      expect(subject.user.email).to be_blank
      expect(subject.user.username).to be_blank
      expect(subject.user.deleted_at).to_not be_blank
    end

  end
end


