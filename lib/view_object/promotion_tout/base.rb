module ViewObject
  module PromotionTout

    class Base
      attr_reader :user, :policy

      def initialize(user, policy)
        @user = user
        @policy = policy
      end

      def renderer
        if user.is_admin? && user.id != policy.submitter_id
          return Renderer::Admin.new(policy)
        end

        Renderer::User.new(policy)
      end

      def render(vc)
        if user && policy.promotable?
          renderer.render(vc)
        end
      end
    end

  end
end
