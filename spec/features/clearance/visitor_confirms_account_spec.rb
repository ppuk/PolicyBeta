require 'rails_helper'

feature 'Visitor confirms account', vcr: true do
  scenario 'user confirms account by clicking emailed link' do
    sign_up_with 'username', 'valid@example.com', 'password'
    user_clicks_confirmation_link

    user_should_see_confirmation_page
  end

  private

  def user_clicks_confirmation_link
    open_email('valid@example.com')
    current_email.click_link 'Confirm my email address'
  end

  def user_should_see_confirmation_page
    expect(page).to have_content I18n.t('confirmations.email_confirmed.title')
  end
end
