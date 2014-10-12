require 'rails_helper'

feature 'Creating a policy as a user', vcr: true do
  let(:user) { create(:user, :with_confirmed_email) }

  scenario 'without an email address' do
    user = create(:user)
    login_as user
    visit new_account_policy_path
    should_ask_the_user_to_confirm_their_email
  end

  scenario 'without a confirmed email address' do
    user = create(:user, :with_email)
    login_as user
    visit new_account_policy_path
    should_ask_the_user_to_confirm_their_email
  end

  scenario 'with a confirmed email address' do
    category = create(:category)
    login_as user

    visit account_policies_path
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

    expect(current_path).to eql(account_policy_path(Policy.last))
  end

end


