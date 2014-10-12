require 'rails_helper'

feature 'Impersonating a user as an admin', vcr: true do
  let!(:user) { create(:user) }

  scenario 'with access' do
    login_as_admin
    visit admin_users_path

    within("tr[data-user-id='#{user.id}']") do
      click_link 'Detail'
    end

    click_link 'Impersonate'

    user_should_be_signed_in(user)
  end

end



