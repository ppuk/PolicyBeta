require 'rails_helper'

feature 'Viewing a policy as an admin', vcr: true do
  let(:policy) { create(:policy) }

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit admin_policy_path(policy)

    page_should_display_missing
  end

  scenario 'with access' do
    login_as_admin
    visit admin_policy_path(policy)

    expect(page).to have_content(policy.title)
    expect(page).to have_content(policy.description)
    expect(page).to have_content(policy.category.name)
  end

  scenario 'with an invalid policy record' do
    login_as_admin
    visit admin_policy_path(0)

    page_should_display_missing
  end

end

