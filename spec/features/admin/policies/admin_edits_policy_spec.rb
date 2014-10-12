require 'rails_helper'

feature 'Editing a policy as an admin', vcr: true do
  let!(:policy) { create(:policy) }

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit edit_admin_policy_path(policy)

    expect(page).not_to have_field('Title', with: policy.title)
    page_should_display_missing
  end

  scenario 'with access' do
    login_as_admin
    visit edit_admin_policy_path(policy)

    expect(page).to have_field('Title', with: policy.title)
    expect(page).to have_field('Description', with: policy.description)
    expect(find('#policy_category_id').value).to eql(policy.category.id.to_s)

    fill_in 'Title', with: 'Changed Policy Title'
    click_button 'Save changes'

    should_display_flash(:success, 'Policy updated')
    expect(page).to have_content('Changed Policy Title')
  end

end
