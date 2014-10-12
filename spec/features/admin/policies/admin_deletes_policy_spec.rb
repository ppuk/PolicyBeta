require 'rails_helper'

feature 'Deleting a policy as an admin', vcr: true do
  let!(:policy) { create(:policy) }

  scenario 'with access', :vcr do
    login_as_admin
    visit admin_policies_path

    click_link policy.title
    click_link 'Fully delete this policy'

    should_display_flash(:success, 'Policy deleted')

    expect(current_path).to eql(admin_policies_path)
    expect(page).not_to have_content(policy.title)
  end

end
