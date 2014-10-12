class Api::V1::EvidenceItemSerializer < Api::V1::BaseSerializer
  attributes :id, :title, :description, :votes_score, :current_vote
  has_one :submitter, serializer: Api::V1::ProfileSerializer

  def votes_score
    object.cached_votes_score || 0
  end

  def current_vote
    if current_user
      return current_user.voted_as_when_voted_for(object)
    end

    nil
  end
end
