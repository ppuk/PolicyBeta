require 'rails_helper'

feature 'Admin signs in', vcr: true do
  scenario 'with valid email and password' do
    create(:admin, email: 'user@example.com')
    sign_in_with 'user@example.com', 'password'

    user_should_be_signed_in
  end

  scenario 'with valid mixed-case email and password ' do
    create(:admin, email: 'user.name@example.com')
    sign_in_with 'User.Name@example.com', 'password'

    user_should_be_signed_in
  end

  scenario 'tries with invalid password' do
    create(:admin, email: 'user@example.com')
    sign_in_with 'user@example.com', 'wrong_password'

    page_should_display_sign_in_error
    user_should_be_signed_out
  end

  scenario 'tries with invalid email' do
    sign_in_with 'unknown.email@example.com', 'password'

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

