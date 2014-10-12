require 'sidekiq/web'

module Routes
  module Admin

    def self.draw(context)
      context.instance_eval do
        namespace :admin do
          mount Sidekiq::Web,
            at: '/sidekiq',
            constraints: ::AccessConstraint::Admin.new

          resource :dashboard, controller: 'dashboards', only: :show

          resources :categories

          resources :policies do
            member do
              post :accept
              post :decline
            end
          end

          resources :users do
            member do
              put  :confirm_email
              put  :unconfirm_email
              post :impersonate
              post :send_password_reset
              delete :soft_delete
            end
          end

          root to: 'dashboards#show'
        end
      end
    end

  end
end
