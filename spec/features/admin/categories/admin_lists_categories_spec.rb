require 'rails_helper'

feature 'Listing categories as an admin', vcr: true do
  let!(:category) { create(:category) }
  let!(:category_2) { create(:category) }

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit admin_categories_path

    page_should_display_missing
  end

  scenario 'with access' do
    login_as_admin
    visit admin_categories_path

    expect(page).to have_content(category.name)
    expect(page).to have_content(category_2.name)
    expect(current_path).to eql(admin_categories_path)
  end

end
