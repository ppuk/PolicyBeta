module Features
  module AccessDenialHelpers

    def should_ask_the_user_to_confirm_their_email
      should_display_flash(:danger, 'You need to add an email address before you can do this')
      expect(current_path).to eql(edit_account_profile_path)
    end

  end
end

