require 'rails_helper'

feature 'Editing a policy as an admin', vcr: true do
  let(:user) { create(:user, :with_confirmed_email) }
  let(:policy) { create(:policy, state: 'suggestion', submitter: user) }

  scenario 'without an email address' do
    user = create(:user)
    login_as user
    visit edit_account_policy_path(policy)
    should_ask_the_user_to_confirm_their_email
  end

  scenario 'without a confirmed email address' do
    user = create(:user, :with_email)
    login_as user
    visit edit_account_policy_path(policy)
    should_ask_the_user_to_confirm_their_email
  end

  scenario 'with access' do
    login_as user
    visit edit_account_policy_path(policy)

    expect(page).to have_field('Title', with: policy.title)
    expect(page).to have_field('Description', with: policy.description)
    expect(find('#policy_category_id').value).to eql(policy.category.id.to_s)

    fill_in 'Title', with: 'Changed Policy Title'
    click_button 'Save changes'

    should_display_flash(:success, 'Policy updated')
    expect(page).to have_content('Changed Policy Title')
    expect(current_path).to eql(account_policy_path(policy))
  end

  scenario 'with an invalid policy record' do
    login_as user
    visit edit_account_policy_path(0)

    page_should_display_missing
  end

  scenario 'when a policy has advanced beyond "suggestion"' do
    policy = create(:policy, state: 'proposition', submitter: user)
    login_as user

    visit edit_account_policy_path(policy)

    expect(page).to have_content('This policy cannot be edited.')
  end

end


