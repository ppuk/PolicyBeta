require 'rails_helper'

feature 'Deleting a category as an admin', vcr: true do
  let!(:category) { create(:category) }
  let!(:category_with_policies) { create(:category, :with_policies) }

  scenario 'with access', :vcr do
    login_as_admin
    visit admin_categories_path

    within("tr[data-category-id='#{category.id}']") do
      click_link 'Detail'
    end

    click_link 'confirm_destroy'

    should_display_flash(:success, 'Category deleted')

    expect(current_path).to eql(admin_categories_path)
    expect(page).not_to have_content(category.name)
  end

  scenario 'with a category that has existing policies' do
    login_as_admin
    visit admin_categories_path

    within("tr[data-category-id='#{category_with_policies.id}']") do
      click_link 'Detail'
    end

    click_link 'confirm_destroy'

    should_display_flash(:danger, 'Category not deleted. Please remove or reassign the associated policies before deleting this category.')

    expect(current_path).to eql(admin_category_path(category_with_policies))
  end

end
