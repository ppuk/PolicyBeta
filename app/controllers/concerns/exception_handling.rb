module Concerns

  module ExceptionHandling
    extend ActiveSupport::Concern

    included do

      protected

      rescue_from CustomException::RequireConfirmedEmail, with: :redirect_to_profile
      rescue_from CustomException::UserBanned, with: :redirect_to_banned
      rescue_from CustomException::LoginRequired, with: :redirect_to_sign_in
      rescue_from CustomException::ForbiddenError, with: :render_missing
      rescue_from ActiveRecord::RecordNotFound, with: :render_missing
      rescue_from ActionController::RoutingError, with: :render_missing

      def render_missing
        render template: 'errors/404', status: 404
      end

      def redirect_to_profile
        flash[:danger] = I18n.t('email_not_confirmed_user', scope: 'flash.user')
        redirect_to edit_account_profile_path
      end

      def redirect_to_sign_in
        redirect_to sign_in_path
      end

      def redirect_to_banned
        # Render the page if we're already on the banned page
        if params[:controller] == 'statics' && params[:action] == 'banned'
          return render 'statics/banned'
        end

        redirect_to banned_path
      end

    end
  end

end
