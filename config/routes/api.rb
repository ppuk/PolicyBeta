module Routes
  module Api

    def self.draw(context)
      context.instance_eval do
        use_doorkeeper scope: 'api/v1/oauth'

        namespace :api do
          namespace :v1 do
            resources :comments, only: [:index, :create]
            resources :passwords, only: :create
            resource :profile, only: [:show, :update], controller: 'profile'
            resources :tags, only: :index
            resources :users, only: :create
            resources :votes, only: [:create, :show]
          end
        end
      end
    end

  end
end
