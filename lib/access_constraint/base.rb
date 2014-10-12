module AccessConstraint
  class Base
    attr_reader :request

    def has_access?
      false
    end

    def current_user
      request.env[:clearance].current_user
    end

    def logged_in?
      current_user.present?
    end

    def matches?(req)
      @request = req

      raise ::CustomException::LoginRequired unless logged_in?
      raise ::CustomException::ForbiddenError unless has_access?

      true
    end
  end
end
