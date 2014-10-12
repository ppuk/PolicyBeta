module Routes
  module Clearance

    def self.draw(context)
      context.instance_eval do
        resources :confirmations,
          only: :show

        resources :passwords,
          controller: 'passwords',
          only: [:create, :new]

        resource :session,
          controller: 'sessions',
          only: [:create]

        resources :users,
          controller: 'users',
          only: [:create] do
            resource :password,
              controlle: 'passwords',
              only: [:create, :edit, :update]
          end

        resource :profile, only: [:show, :edit, :update, :destroy]

        get '/sign_in' => 'sessions#new', as: nil
        delete '/sign_out' => 'sessions#destroy', as: nil
        get '/sign_up' => 'users#new', as: nil
      end
    end

  end
end
