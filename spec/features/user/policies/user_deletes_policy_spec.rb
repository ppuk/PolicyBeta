require 'rails_helper'

feature 'Deleting a policy as a user', vcr: true do
  let(:user) { create(:user, :with_confirmed_email) }
  let!(:policy) { create(:policy, submitter: user) }

  scenario 'with access', :vcr do
    login_as(user)
    visit account_policies_path

    click_link policy.title
    click_link 'Fully delete this policy'

    should_display_flash(:success, 'Policy deleted')
    expect(current_path).to eql(account_policies_path)
    expect(page).not_to have_content(policy.title)
  end

end
