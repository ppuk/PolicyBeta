require 'rails_helper'

feature 'Creating a user as an admin', vcr: true do

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit new_admin_user_path

    page_should_display_missing
  end

  scenario 'with access' do
    login_as_admin
    visit admin_users_path

    click_link 'New user'

    expect(page).to have_field('Email')

    fill_in 'Username', with: 'username_new'
    fill_in 'Email', with: 'new@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Create user'

    should_display_flash(:success, 'User created')
    expect(page).to have_content('username_new')
  end

end


