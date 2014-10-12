require 'rails_helper'

feature 'Viewing a user as an admin', vcr: true do
  let(:user) { create(:user, :with_ip_logs) }

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit admin_user_path(user)

    expect(page).not_to have_content(user.username)
    page_should_display_missing
  end

  scenario 'with access' do
    login_as_admin
    visit admin_user_path(user)

    expect(page).to have_content(user.username)
  end

  scenario 'with an invalid user record' do
    login_as_admin
    visit admin_user_path(0)

    expect(page).not_to have_content(user.username)
    page_should_display_missing
  end

end

