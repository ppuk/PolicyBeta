require 'rails_helper'

feature 'Listing policies as a user', vcr: true do
  let(:user) { create(:user, :with_confirmed_email) }
  let!(:policy) { create(:policy, submitter: user) }
  let!(:policy_2) { create(:policy, submitter: user) }

  scenario 'without proper access' do
    login_as create(:user)
    visit account_policies_path
    should_ask_the_user_to_confirm_their_email
  end

  scenario 'with access' do
    login_as user
    visit account_policies_path

    expect(page).to have_content(policy.title)
    expect(page).to have_content(policy_2.title)
    expect(current_path).to eql(account_policies_path)
  end

  scenario 'searching for a policy' do
    login_as user
    visit account_policies_path(search: { query: policy.title })

    expect(page).to have_content(policy.title)
    expect(page).not_to have_content(policy_2.title)
    expect(current_path).to eql(account_policies_path)
  end

end
