require 'rails_helper'

feature 'Visitor signs up', vcr: true do
  scenario 'by navigating to the page' do
    visit sign_in_path

    click_link 'Sign Up'

    expect(current_path).to eq sign_up_path
  end

  scenario 'with valid username, email and password' do
    sign_up_with 'user_1', 'valid@example.com', 'password'

    user_should_be_signed_in
  end

  scenario 'with valid username, no email and a password' do
    sign_up_with 'user_1', '', 'password'

    user_should_be_signed_in
  end

  scenario 'with valid email and password but no username' do
    sign_up_with '', 'valid@example.com', 'password'

    user_should_be_signed_out
  end

  scenario 'tries with invalid email' do
    sign_up_with 'username', 'invalid_email', 'password'

    user_should_be_signed_out
  end

  scenario 'tries with blank password' do
    sign_up_with 'username', 'valid@example.com', ''

    user_should_be_signed_out
  end
end
