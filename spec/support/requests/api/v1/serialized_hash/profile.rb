module Requests
  module Api
    module V1
      module SerializedHash
        module Profile
          def profile_serialized_hash(user)
            {
              id: user.id,
              email: user.email,
              username: user.username,
              role: user.is_admin? ? 'admin' : 'user'
            }
          end
        end
      end
    end
  end
end
