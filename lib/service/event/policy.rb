module Service
  module Event
    class Policy < Service::Event::Base
      attr_accessor :policy

      def initialize(policy)
        @policy = policy
      end

      def created
        log 'policy.created'
        log "policy.created.#{policy.id}"
        log "policy.created.user.#{submitter.id}"
      end

      def updated
        log 'policy.updated'
        log "policy.updated.#{policy.id}"
        log "policy.updated.user.#{submitter.id}"
      end

      def destroyed
        log 'policy.destroyed'
        log "policy.destroyed.#{policy.id}"
        log "policy.destroyed.user.#{submitter.id}"
      end
    end
  end
end
