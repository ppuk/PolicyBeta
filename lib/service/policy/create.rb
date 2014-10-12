module Service
  module Policy

    class Create < Service::Base
      attribute :title,       String
      attribute :description, String

      attr_accessor :user

      delegate :errors, :valid?, to: :policy

      def policy
        @policy ||= ::Policy.new({
          submitter: user,
          title: title,
          description: description
        })
      end

      def process
        if policy.save
          ::Service::Event::Policy.new(policy).created
        else
          return false
        end

        true
      end
    end

  end
end

