module ViewObject
  module PromotionTout
    module Renderer

      class User < ViewObject::PromotionTout::Renderer::Base
        def partial
          case policy.promotion_state
          when 'waiting'
            'account/policies/promotion_tout/request_promotion'
          when 'admin_requested'
            'account/policies/promotion_tout/confirm_promotion'
          else
            'account/policies/promotion_tout/waiting_on_user'
          end
        end
      end

    end
  end
end
