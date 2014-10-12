module Routes
  module Public

    def self.draw(context)
      context.instance_eval do
        get ':status', to: 'errors#show', constraints: { status: /\d{3}/ }
        get 'banned', to: 'statics#banned', as: :banned
      end
    end

  end
end
