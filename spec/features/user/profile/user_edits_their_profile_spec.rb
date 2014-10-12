require 'rails_helper'

feature 'User edits their profile', vcr: true do
  let(:user) { create(:user) }

  scenario 'without proper access' do
    visit edit_account_profile_path
    page_should_redirect_to_sign_in
  end

  scenario 'changing email address not yet confirmed' do
    user = create(:user, :with_email)

    sign_in_with user.username, 'password'
    click_link 'My profile'

    click_link 'Edit profile'

    expect(page).to have_content('Edit Profile')
    expect(page).to have_field('Email', with: user.email)

    fill_in 'Email', with: 'changed@example.com'
    click_button 'Save changes'

    should_display_flash(:success, 'User updated')
    expect(page).to have_content('My profile')
    expect(page).to have_content('changed@example.com')

    user_should_be_sent_a_confirmation_email

    user.reload
    expect(user.email_confirmed?).to be_falsy
  end

  scenario 'changing email address with a confirmed email' do
    user = create(:user, :with_confirmed_email)

    sign_in_with user.username, 'password'
    click_link 'My profile'

    click_link 'Edit profile'

    expect(page).to have_content('Edit Profile')
    expect(page).to have_field('Email', with: user.email)

    fill_in 'Email', with: 'changed@example.com'
    click_button 'Save changes'

    should_display_flash(:success, 'User updated')
    expect(page).to have_content('My profile')
    expect(page).to have_content('changed@example.com')

    user_should_be_sent_a_confirmation_email

    user.reload
    expect(user.email_confirmed?).to be_falsy
  end

  scenario 'specifying a new email address' do
    sign_in_with user.username, 'password'
    click_link 'My profile'

    click_link 'Edit profile'

    expect(page).to have_content('Edit Profile')
    expect(page).to have_field('Email', with: '')

    fill_in 'Email', with: 'changed@example.com'
    click_button 'Save changes'

    should_display_flash(:success, 'User updated')
    expect(page).to have_content('My profile')
    expect(page).to have_content('changed@example.com')

    user_should_be_sent_a_confirmation_email

    user.reload
    expect(user.email_confirmed?).to be_falsy
  end

  private

  def user_should_be_sent_a_confirmation_email
    open_email 'changed@example.com'
    expect(current_email).to_not be_nil
    expect(current_email.subject).to eql('Confirm your email address')
  end
end
