module Service
  module Event
    class User < Service::Event::Base
      attr_accessor :user

      def initialize(user)
        @user = user
      end

      def email_confirmed
        log 'user.email_confirmed'
        log "user.email_confirmed.#{user.id}"
      end

      def signed_in
        log 'user.login'
        log "user.login.#{user.id}"
      end

      def signed_up
        log 'user.signup'
        log "user.signup.#{user.id}"
      end

      def password_reset
        log 'user.password_reset'
        log "user.password_reset.#{user.id}"
      end

      def soft_deleted
        log 'user.soft_delete'
        log "user.soft_delete.#{user.id}"
      end
    end
  end
end
