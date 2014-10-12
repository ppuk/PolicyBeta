module Service
  module Policy

    class Decline < Service::Base
      attribute :policy, ::Policy

      def notify_user
        SendPolicyMail.perform_async(:policy_declined, policy.id)
      end

      def process
        policy.update_attribute(:state, 'rejected')
        notify_user
      end

      def valid?
        policy.present?
      end
    end

  end
end


