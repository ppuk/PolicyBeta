require 'rails_helper'

describe IpLog, :type => :model do
  describe '#log_ip' do
    let(:user) { double }
    let(:perform) { IpLog.log_ip('127.0.0.1', user) }

    let(:prior_logs) { double }

    before(:each) do
      allow(IpLog).to receive(:log_ip).and_call_original

      allow(user).to receive(:ip_logs).and_return(prior_logs)
      allow(user).to receive(:update_attribute).and_return(true)

      allow(prior_logs).to receive(:create).and_return(true)
      allow(prior_logs).to receive(:where).with(ip: '127.0.0.1').and_return(prior_logs)
      allow(prior_logs).to receive(:first).and_return(log)
    end

    describe 'when the ip has been seen for the user' do
      let!(:log) { double }

      before(:each) do
        allow(log).to receive(:update_attribute).and_return(true)
      end

      it 'should not create a new ip log' do
        expect(IpLog).to receive(:update_log).with(log)
        perform
      end
    end

    describe 'when the ip has not been seen for the user' do
      let(:log) { nil }

      it 'should create a new ip log' do
        expect(IpLog).to receive(:create_log).with('127.0.0.1', user).and_return(true)
        perform
      end
    end
  end
end
