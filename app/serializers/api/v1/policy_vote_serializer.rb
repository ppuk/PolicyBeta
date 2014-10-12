module Api
  module V1
    class PolicyVoteSerializer < Api::V1::VoteSerializer
      has_one :votable, serializer: Api::V1::PolicySerializer
    end
  end
end
