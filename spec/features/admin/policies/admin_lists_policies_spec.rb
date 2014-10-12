require 'rails_helper'

feature 'Listing policies as an admin', vcr: true do
  let!(:policy) { create(:policy) }
  let!(:policy_2) { create(:policy) }

  scenario 'without proper access' do
    sign_up_with 'username', 'user@example.com', 'password'
    sign_in_with 'user@example.com', 'password'
    visit admin_policies_path

    page_should_display_missing
  end

  scenario 'with access' do
    login_as_admin
    visit admin_policies_path

    expect(page).to have_content(policy.title)
    expect(page).to have_content(policy_2.title)
    expect(current_path).to eql(admin_policies_path)
  end

  scenario 'searching for a policy' do
    login_as_admin
    visit admin_policies_path(search: { query: policy.title })

    expect(page).to have_content(policy.title)
    expect(page).not_to have_content(policy_2.title)
    expect(current_path).to eql(admin_policies_path)
  end

end
