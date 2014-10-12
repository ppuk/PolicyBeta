require 'rails_helper'

feature 'Deleting a user as an admin', vcr: true do
  let!(:user) { create(:user) }

  scenario 'full delete', :vcr do
    login_as_admin
    visit admin_users_path

    within("tr[data-user-id='#{user.id}']") do
      click_link 'Detail'
    end

    click_link 'Fully delete this account'

    should_display_flash(:success, 'User deleted')
    expect(page).not_to have_content(user.username)
  end

  scenario 'soft delete', :vcr do
    login_as_admin
    visit admin_users_path

    within("tr[data-user-id='#{user.id}']") do
      click_link 'Detail'
    end

    click_link 'Anonymise this account'

    should_display_flash(:success, 'User anonymised')
    expect(page).not_to have_content(user.username)
  end

end
