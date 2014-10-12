require 'rails_helper'

feature 'Editing a category as an admin', vcr: true do
  let!(:category) { create(:category) }

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit edit_admin_category_path(category)

    page_should_display_missing
  end

  scenario 'with access' do
    login_as_admin
    visit edit_admin_category_path(category)

    expect(page).to have_field('Name', with: category.name)
    expect(page).to have_field('Colour', with: category.colour)

    fill_in 'Name', with: 'Changed Name'
    click_button 'Save changes'

    should_display_flash(:success, 'Category updated')
    expect(page).to have_content('Changed Name')
  end

end


