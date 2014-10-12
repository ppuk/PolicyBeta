require 'rails_helper'

feature 'User visits admin dashboard', vcr: true do

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit admin_root_path

    expect(page).not_to have_content('Dashboard')
    page_should_display_missing
  end

  scenario 'with access' do
    create(:admin, email: 'user@example.com')
    sign_in_with 'user@example.com', 'password'
    visit admin_root_path

    expect(page).to have_content('Dashboard')
  end

end
