module ViewObject
  module PromotionTout
    module Renderer

      class Base
        attr_reader :policy

        def initialize(policy)
          @policy = policy
        end

        def partial
        end

        def render(vc)
          vc.render partial: partial
        end
      end

    end
  end
end

