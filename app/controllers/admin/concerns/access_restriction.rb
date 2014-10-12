module Admin::Concerns

  module AccessRestriction
    extend ActiveSupport::Concern

    included do
      before_action :authorize_admin

      private

      def authorize_admin
        if !signed_in?
          raise CustomException::LoginRequired
        end

        if !current_user.is_admin?
          raise CustomException::ForbiddenError
        end
      end
    end
  end

end

