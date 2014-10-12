require 'rails_helper'

feature 'Confirming a users email address as an admin', vcr: true do
  let!(:user) { create(:user, :with_email) }

  scenario 'with access' do
    login_as_admin
    visit admin_users_path

    within("tr[data-user-id='#{user.id}']") do
      click_link 'Detail'
    end

    click_link 'Confirm email'

    should_display_flash(:success, 'User email confirmed')

    user.reload
    expect(user.email_confirmed?).to be_truthy
  end

end
