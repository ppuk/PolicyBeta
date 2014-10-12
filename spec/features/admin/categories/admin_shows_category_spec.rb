require 'rails_helper'

feature 'Viewing a category as an admin', vcr: true do
  let(:category) { create(:category) }

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit admin_category_path(category)

    page_should_display_missing
  end

  scenario 'with access' do
    login_as_admin
    visit admin_category_path(category)

    expect(page).to have_content(category.name)
  end

  scenario 'with an invalid category record' do
    login_as_admin
    visit admin_category_path(0)

    page_should_display_missing
  end

end

