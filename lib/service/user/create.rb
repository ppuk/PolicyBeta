module Service
  module User

    class Create < Service::Base
      attribute :username, String
      attribute :email,    String
      attribute :password, String

      delegate :valid?, :errors, to: :user

      def user
        @user ||= ::User.new(
          username: username,
          email: email,
          password: password
        )
      end

      def process
        if user.save
          ::Service::Event::User.new(@user).signed_up
          SendUserMail.perform_async(:welcome, user.id) if user.email.present?
        else
          return false
        end

        true
      end
    end

  end
end
