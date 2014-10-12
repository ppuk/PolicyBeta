module Features
  module AdminHelpers

    def login_as_admin
      admin = create(:admin)
      sign_in_with admin.email, 'password'

      user_should_be_signed_in(admin)
    end

  end
end
