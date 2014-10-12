RSpec.configure do |config|
  config.before(:each) do
    allow(IpLog).to receive(:log_ip).and_return true
  end
end
