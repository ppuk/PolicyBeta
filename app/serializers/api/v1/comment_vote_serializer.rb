module Api
  module V1
    class CommentVoteSerializer < Api::V1::VoteSerializer
      has_one :votable, serializer: Api::V1::CommentSerializer
    end
  end
end
