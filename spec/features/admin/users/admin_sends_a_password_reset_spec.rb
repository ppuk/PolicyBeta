require 'rails_helper'

feature 'Sending a password reset as an admin', vcr: true do
  let!(:unconfirmed_user) { create(:user, :with_email) }
  let!(:confirmed_user) { create(:user, :with_confirmed_email) }

  scenario 'when the user has not confirmed their email address' do
    login_as_admin
    visit admin_users_path

    within("tr[data-user-id='#{unconfirmed_user.id}']") do
      click_link 'Detail'
    end

    click_link 'Send password reset'
    should_display_flash(:danger, 'Users email has not been confirmed')
  end

  scenario 'when the user has confirmed their email address' do
    login_as_admin
    visit admin_users_path

    within("tr[data-user-id='#{confirmed_user.id}']") do
      click_link 'Detail'
    end

    click_link 'Send password reset'
    should_display_flash(:success, 'Password reset sent')
  end

end
