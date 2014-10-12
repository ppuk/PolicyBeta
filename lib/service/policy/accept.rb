module Service
  module Policy

    class Accept < Service::Base
      attribute :policy, ::Policy

      delegate :errors, :valid?, to: :new_policy

      def new_policy
        return @new_policy if @new_policy
        @new_policy = policy.dup

        @new_policy.cached_votes_total = 0
        @new_policy.cached_votes_score = 0
        @new_policy.cached_votes_up = 0
        @new_policy.cached_votes_down = 0
        @new_policy.cached_weighted_score = 0
        @new_policy.cached_weighted_total = 0
        @new_policy.cached_weighted_average = 0
        @new_policy.comments_count = 0
        @new_policy.promotion_state = 'waiting'
        @new_policy.state = 'suggestion'
        @new_policy.submitter = policy.submitter
        @new_policy.previous_version_id = policy.id

        @new_policy
      end

      def duplicate_policy
        new_policy.save!
      end

      def notify_user
        SendPolicyMail.perform_async(:policy_accepted, new_policy.id)
      end

      def process
        policy.update_attribute(:state, 'passed')
        duplicate_policy && notify_user
      end
    end

  end
end


