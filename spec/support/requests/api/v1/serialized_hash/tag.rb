module Requests
  module Api
    module V1
      module SerializedHash
        module Tag
          def tag_serialized_hash(tag)
            {
              id: tag.id,
              name: tag.name,
              taggings_count: tag.taggings_count
            }
          end
        end
      end
    end
  end
end

