module Routes
  module Policy

    def self.draw(context)
      context.instance_eval do
        resources :policies, only: [:index, :show] do
          member do
            put :request_promotion,  controller: :promotions
            put :approve_promotion,  controller: :promotions
            put :decline_promotion,  controller: :promotions
          end
        end

        root 'policies#index'
      end
    end

  end
end

