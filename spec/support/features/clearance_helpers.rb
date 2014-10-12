module Features
  module ClearanceHelpers
    def sign_up_with(username, email, password)
      visit sign_up_path
      fill_in 'user_username', with: username
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'Sign up'
    end

    def sign_in_with(email_or_username, password)
      visit sign_in_path
      fill_in 'session_email', with: email_or_username
      fill_in 'session_password', with: password
      click_button I18n.t('helpers.submit.session.submit')
    end

    def signed_in_user
      password = 'password'
      user = create(:user, password: password)
      sign_in_with user.email, password
      user
    end

    def login_as(user)
      username = user.email.blank? ? user.username : user.email
      sign_in_with username, 'password'
    end

    def user_should_be_signed_in(user=nil)
      visit root_path
      expect(page).to have_content I18n.t('header.sign_out')
      expect(page).to have_content "My account" if user
    end

    def sign_out
      click_link I18n.t('header.sign_out')
    end

    def user_should_be_signed_out
      expect(page).to have_content I18n.t('header.sign_in')
      expect(page).not_to have_content "My account"
    end

    def user_with_reset_password
      user = create(:user, :with_confirmed_email)
      reset_password_for user.email
      user.reload
      user
    end

    def reset_password_for(email)
      visit new_password_path
      fill_in 'password_email', with: email
      click_button I18n.t('helpers.submit.password.submit')
    end

    def mailer_should_have_no_deliveries
      expect(ActionMailer::Base.deliveries).to be_empty
    end
  end
end
