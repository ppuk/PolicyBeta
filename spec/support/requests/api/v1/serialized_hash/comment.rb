module Requests
  module Api
    module V1
      module SerializedHash
        module Comment

          def comment_serialized_hash(comment)
            {
              id: comment.id,
              body: comment.body,
              replies_count: comment.comments_count,
              created_at: comment.created_at.utc.iso8601,
              user: profile_serialized_hash(comment.user),
              votes_score: 0,
              current_vote: nil
            }
          end

        end
      end
    end
  end
end

