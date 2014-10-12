module Concerns

  module IpLogging
    extend ActiveSupport::Concern

    included do
      before_action :update_ip

      protected

      def update_ip
        if signed_in? && current_user.last_ip != request.ip
          IpLog.log_ip(request.ip, current_user)
        end
      end

    end
  end

end

