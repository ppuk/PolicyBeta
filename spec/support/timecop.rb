RSpec.configure do |config|

  config.before(:each, type: :request) do
    Timecop.freeze
  end

  config.after(:each) do
    Timecop.return
  end

end


