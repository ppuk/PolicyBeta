require 'rails_helper'

feature 'Soft Deleting a user as an admin', vcr: true do
  let!(:user) { create(:user) }

  scenario 'with access', :vcr do
    login_as_admin
    visit admin_users_path

    within("tr[data-user-id='#{user.id}']") do
      click_link 'Detail'
    end

    click_link 'confirm_anonymise'

    should_display_flash(:success, 'User anonymised')
    expect(page).not_to have_content(user.username)

    user.reload
    expect(user.username).to be_blank
    expect(user.email).to be_blank
    expect(user.deleted_at).to_not be_blank
  end

end
