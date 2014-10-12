require 'rails_helper'

feature 'Creating a policy as an admin', vcr: true do

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit new_admin_policy_path

    page_should_display_missing
  end

  scenario 'with access' do
    category = create(:category)
    login_as_admin
    visit admin_policies_path

    click_link 'Submit a new policy'

    expect(page).to have_field('Title')
    expect(page).to have_field('Description')
    expect(page).to have_field('Category')

    fill_in 'Title', with: 'New policy title'
    fill_in 'Description', with: 'A description'
    find('#policy_category_id').find("option[value='#{category.id}']").select_option
    click_button 'Create policy'

    should_display_flash(:success, 'Policy created')
    expect(page).to have_content('New policy title')
    expect(page).to have_content('A description')
    expect(page).to have_content(category.name)
  end

end


