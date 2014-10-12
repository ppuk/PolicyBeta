module Concerns

  module Authorization
    extend ActiveSupport::Concern
    include Clearance::Controller

    included do
      before_action :check_banned

      # L2 user is just a user with a confirmed email address
      # Certain actions in the system require this.
      def require_l2_user
        unless current_user.email_confirmed?
          raise CustomException::RequireConfirmedEmail
        end
      end

      def check_banned
        raise CustomException::UserBanned if current_user.try(:banned?)
      end

      def current_user
        user = super
        UserDecorator.decorate(user) unless user.nil?
      end

      def scope
        AccessScope::Base.new(current_user)
      end
    end
  end

end


