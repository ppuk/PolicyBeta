require 'rails_helper'

describe Service::Policy::Create do

  describe '.perform' do
    subject { described_class.new(title: 'new title') }
    let(:user) { build_stubbed(:user, :with_confirmed_email) }
    let(:policy) { build_stubbed(:policy) }
    let(:event) { double created: true }

    before(:each) do
      allow(Policy).to receive(:new).and_return(policy)
      allow(Service::Event::Policy).to receive(:new).and_return(event)
    end

    context 'with valid params' do
      before(:each) do
        allow(policy).to receive(:save).and_return(true)
        subject.user = user
      end

      it 'should return true' do
        expect(subject.perform).to be_truthy
      end

      it 'should log the creation event' do
        expect(event).to receive(:created)
        subject.perform
      end

      it 'should set the attributes correctly' do
        expect(Policy).to receive(:new).with({
          submitter: user,
          title: 'new title',
          description: nil
        }).and_return(policy)

        subject.perform
      end
    end

    context 'with invalid params' do
      before(:each) do
        allow(policy).to receive(:save).and_return(false)
      end

      it 'should return false' do
        expect(subject.perform).to be_falsey
      end
    end
  end

end

