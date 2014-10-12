require 'rails_helper'

feature 'Listing users as an admin', vcr: true do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit admin_users_path

    page_should_display_missing
  end

  scenario 'with access' do
    login_as_admin
    visit admin_users_path

    expect(page).to have_content(admin.username)
    expect(page).to have_content(user.username)
    expect(current_path).to eql(admin_users_path)
  end

  scenario 'searching for a user' do
    login_as_admin
    visit admin_users_path(search: { query: admin.email })

    expect(page).to have_content(admin.username)
    expect(page).not_to have_content(user.username)
    expect(current_path).to eql(admin_users_path)
  end

end
