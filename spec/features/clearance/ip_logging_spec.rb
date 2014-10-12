require 'rails_helper'

feature 'Log IP address on sign in', vcr: true do
  scenario 'with a valid user' do
    allow(IpLog).to receive(:log_ip).and_call_original

    expect(IpLog.count).to eql(0)
    create(:user, email: 'user@example.com', password: 'password')
    sign_in_with 'user@example.com', 'password'
    expect(IpLog.count).to eql(1)
  end
end
