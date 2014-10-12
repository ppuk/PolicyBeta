module Account
  module Concerns

    module AccessRestriction
      extend ActiveSupport::Concern

      included do
        before_action :authorize_user

        private

        def authorize_user
          raise CustomException::LoginRequired unless signed_in?
        end
      end
    end

  end
end
