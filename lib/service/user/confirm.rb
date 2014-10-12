module Service
  module User

    class Confirm < Service::Base
      attribute :id,         Integer
      attribute :token,      String
      attribute :email_hash, String

      EMAIL_CONFIRMATION_TOKEN_LENGTH = 40

      def self.generate_token
        SecureRandom.hex(EMAIL_CONFIRMATION_TOKEN_LENGTH / 2)
      end

      def process
        if valid?
          user.confirm_email!
          ::Service::Event::User.new(user).email_confirmed
        else
          return false
        end

        true
      end

      def user
        @user ||= ::User.unconfirmed_email.find(id)
      end

      def valid?
        user.email_confirmation_token == token &&
          token.length == EMAIL_CONFIRMATION_TOKEN_LENGTH &&
          user.hash_matches?(email_hash)
      end
    end

  end
end

