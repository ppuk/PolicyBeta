FactoryGirl.define do

  factory :ip_log do
    user
    ip { Faker::Internet.ip_v4_address }
    last_seen { rand(10).days.ago }
  end

end
