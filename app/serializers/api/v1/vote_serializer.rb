module Api
  module V1
    class VoteSerializer < Api::V1::BaseSerializer
      attributes :vote_flag
      has_one :voter, serializer: Api::V1::ProfileSerializer

      root :vote
    end
  end
end
