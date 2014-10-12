require 'rails_helper'

feature 'Visitor signs in', vcr: true do
  scenario 'with valid email and password' do
    user = create(:user)
    sign_in_with user.email, 'password'

    user_should_be_signed_in
  end

  scenario 'with valid username and password' do
    user = create(:user)
    sign_in_with user.username, 'password'

    user_should_be_signed_in
  end

  scenario 'with valid mixed-case email and password ' do
    user = create(:user)
    sign_in_with user.email.upcase, 'password'

    user_should_be_signed_in
  end

  scenario 'with valid mixed-case username and password ' do
    user = create(:user)
    sign_in_with user.username.upcase, 'password'

    user_should_be_signed_in
  end

  scenario 'tries with invalid password' do
    user = create(:user)
    sign_in_with user.email, 'wrong_password'

    page_should_display_sign_in_error
    user_should_be_signed_out
  end

  scenario 'tries with invalid email' do
    sign_in_with 'unknown.email@example.com', 'password'

    page_should_display_sign_in_error
    user_should_be_signed_out
  end

  scenario 'signs in when banned' do
    user = create(:user, :banned)
    sign_in_with user.email, 'password'

    user_should_be_signed_in
    expect(page).to have_content('Banned')
  end

  scenario 'tries with soft deleted account' do
    user = create(:user, :deleted)
    sign_in_with user.username, 'password'

    page_should_display_sign_in_error
    user_should_be_signed_out
  end

  private

  def page_should_display_sign_in_error
    expect(page.body).to include(
      I18n.t('flashes.failure_after_create', sign_up_path: sign_up_path)
    )
  end
end
