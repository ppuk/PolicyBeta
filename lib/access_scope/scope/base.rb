module AccessScope
  module Scope

    class Base
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def viewable_policies
        ::Policy
      end

      def method_missing(method)
        raise CustomException::ForbiddenError
      end
    end

  end
end
