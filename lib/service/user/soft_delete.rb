module Service
  module User

    class SoftDelete < Service::Base
      attr_reader :user

      def valid?
        true
      end

      def initialize(user)
        @user = user
      end

      def process
        user.email = ''
        user.username = ''
        user.deleted_at = Time.now.utc
        user.ip_logs.destroy_all

        if user.save(validate: false)
          ::Service::Event::User.new(@user).soft_deleted
          return true
        end

        false
      end
    end

  end
end

