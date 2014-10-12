module ViewObject
  module PromotionTout
    module Renderer

      class Admin < ViewObject::PromotionTout::Renderer::Base
        def partial
          case policy.promotion_state
          when 'waiting'
            'admin/policies/promotion_tout/request_promotion'
          when 'user_requested'
            'admin/policies/promotion_tout/confirm_promotion'
          else
            'admin/policies/promotion_tout/waiting_on_user'
          end
        end
      end

    end
  end
end
