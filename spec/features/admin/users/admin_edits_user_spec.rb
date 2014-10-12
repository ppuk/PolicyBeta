require 'rails_helper'

feature 'Editing a user as an admin', vcr: true do
  let!(:user) { create(:user) }

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit edit_admin_user_path(user)

    expect(page).not_to have_field('Email', with: user.email)
    page_should_display_missing
  end

  scenario 'with access' do
    login_as_admin
    visit edit_admin_user_path(user)

    expect(page).to have_field('Email', with: user.email)

    fill_in 'Email', with: 'changed@example.com'
    click_button 'Save changes'

    should_display_flash(:success, 'User updated')
    expect(page).to have_content('changed@example.com')
  end

  scenario 'with an invalid user record' do
    login_as_admin
    visit edit_admin_user_path(0)

    expect(page).not_to have_field('Email', with: user.email)
    page_should_display_missing
  end

end


