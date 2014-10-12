module Api::V1::Concerns

  module AccessRestriction
    extend ActiveSupport::Concern

    AVAILABLE_ROLES = {
      admin: 'admin',
      user: 'user'
    }

    included do
      helper_method :current_user

      protected

      def clearance_session
        request.env[:clearance]
      end

      def current_user
        @current_user ||=
          clearance_session.current_user ||
          (User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token)

        raise CustomException::UserBanned if @current_user && @current_user.banned?

        @current_user
      end

      def self.restrict_to(*options)
        opts = options.extract_options!
        conditions = []

        [options].flatten.each do |user_type|
          conditions << AVAILABLE_ROLES[user_type]
        end

        before_filter(opts) do
          unless current_user.present? && conditions.include?(current_user.role)
            render_forbidden
          end
        end
      end
    end
  end

end

