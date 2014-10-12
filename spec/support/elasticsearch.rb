RSpec.configure do |config|

  config.before(:each, vcr: true) do
    begin
      UsersIndex.reset!
      PoliciesIndex.reset!
      TagsIndex.reset!
    rescue Faraday::ConnectionFailed
      nil
    end
  end

end
