module Requests
  module Api
    module V1
      module SerializedHash
        module Policy

          def policy_serialized_hash(policy)
            {
              id: policy.id,
              title: policy.title,
              description: policy.description,
              category: category_serialized_hash(policy.category),
              votes_score: 0,
              current_vote: nil,
              submitter: profile_serialized_hash(policy.submitter)
            }
          end

        end
      end
    end
  end
end
