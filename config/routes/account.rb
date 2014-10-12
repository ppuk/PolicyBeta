module Routes
  module Account

    def self.draw(context)
      context.instance_eval do
        namespace :account do
          resources :policies do
            resources :evidence_items, only: [:edit, :update, :new, :create, :destroy]
          end

          resource :profile, controller: 'profile' do
            member do
              delete :soft_delete
            end
          end

          root to: 'profile#show'
        end
      end
    end

  end
end
