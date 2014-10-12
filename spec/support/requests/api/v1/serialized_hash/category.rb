module Requests
  module Api
    module V1
      module SerializedHash
        module Category

          def category_serialized_hash(category)
            {
              id: category.id,
              name: category.name,
              colour: category.colour
            }
          end

        end
      end
    end
  end
end

