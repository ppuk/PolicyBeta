module Api::V1::Concerns

  module ExceptionHandling
    extend ActiveSupport::Concern

    included do

      protected

      rescue_from CustomException::UserBanned, with: :render_forbidden
      rescue_from CustomException::LoginRequired, with: :render_unauthorized
      rescue_from CustomException::ForbiddenError, with: :render_forbidden
      rescue_from ActiveRecord::RecordNotFound, with: :render_missing
      rescue_from ActionController::RoutingError, with: :render_missing

      def render_missing
        head status: 404
      end

      def render_unauthorized
        head status: 401
      end

      def render_forbidden
        head status: 403
      end

    end
  end

end
