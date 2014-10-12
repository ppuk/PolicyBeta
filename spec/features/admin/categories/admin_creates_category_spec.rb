require 'rails_helper'

feature 'Creating a category as an admin', vcr: true do

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit new_admin_category_path

    page_should_display_missing
  end

  scenario 'with access' do
    login_as_admin
    visit admin_categories_path

    click_link 'New'

    expect(page).to have_field('Name')
    expect(page).to have_field('Colour')

    fill_in 'Name', with: 'New category name'
    fill_in 'Colour', with: '#ffffff'
    click_button 'Create category'

    should_display_flash(:success, 'Category created')
    expect(page).to have_content('New category name')
  end

  scenario 'with invalid attributes' do
    login_as_admin
    visit admin_categories_path

    click_link 'New'

    expect(page).to have_field('Name')
    expect(page).to have_field('Colour')

    fill_in 'Name', with: ''
    fill_in 'Colour', with: ''
    click_button 'Create category'

    expect(page).to have_field('Name', with: '')
    expect(page).to have_field('Colour', with: '')
  end

end


