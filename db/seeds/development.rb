require 'factory_girl'
include FactoryGirl::Syntax::Methods

Dir[Rails.root.join("spec/factories/**/*.rb")].each {|f| require f}

3.times do
  puts 'create admin'
  create(:admin, :with_submitted_policies)
end

10.times do
  puts 'create user with confirmed email'
  create(:user, :with_confirmed_email, :with_submitted_policies)

  puts 'create user with non-confirmed email'
  create(:user, :with_email)

  puts 'create user without email'
  create(:user)
end
