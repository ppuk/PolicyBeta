require 'rails_helper'

feature 'User deletes their profile', vcr: true do
  let(:user) { create(:user) }

  scenario 'with access' do
    sign_in_with user.email, 'password'
    click_link 'My profile'

    click_link 'Fully delete my account'

    should_display_flash(:success, 'User deleted')
    user_should_be_signed_out
  end
end

feature 'User anonymises their profile', vcr: true do
  let(:user) { create(:user) }

  scenario 'with access' do
    sign_in_with user.email, 'password'
    click_link 'My profile'

    click_link 'Anonymise my account'

    should_display_flash(:success, 'User anonymised')
    user_should_be_signed_out
  end
end
