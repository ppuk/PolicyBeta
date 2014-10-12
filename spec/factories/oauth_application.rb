FactoryGirl.define do

  factory :oauth_application, class: Doorkeeper::Application do
    sequence(:name) {|i| "App #{i}" }
    redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
  end

end
