require 'rails_helper'

describe SessionsController, type: :controller do

  describe 'url_after_create' do
    let(:user) { double(id: 1) }
    let(:event) { double }
    let(:subject) { controller }

    before(:each) do
      allow(subject).to receive(:current_user).and_return(user)
    end

    it 'should log the user event' do
      expect(Service::Event::User).to receive(:new).with(user).and_return(event)
      expect(event).to receive(:signed_in).once
      subject.send(:url_after_create)
    end

    it 'should return the correct url' do
      url = '/'
      expect(subject.send(:url_after_create)).to eql(url)
    end
  end

end
