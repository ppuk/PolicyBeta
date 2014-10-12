require 'rails_helper'

feature 'User views their profile', vcr: true do
  let(:user) { create(:user) }

  scenario 'without proper access' do
    visit account_profile_path
    page_should_redirect_to_sign_in
  end

  scenario 'with access' do
    sign_in_with user.email, 'password'
    click_link 'My profile'

    expect(page).to have_content(user.email)
    expect(page).to have_content('My Profile')
  end

end


