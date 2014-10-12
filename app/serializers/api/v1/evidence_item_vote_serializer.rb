module Api
  module V1
    class EvidenceItemVoteSerializer < Api::V1::VoteSerializer
      has_one :votable, serializer: Api::V1::EvidenceItemSerializer
    end
  end
end
