class Api::V1::CommentSerializer < Api::V1::BaseSerializer
  attributes :id, :body, :created_at, :replies_count, :votes_score, :current_vote

  has_one :user, serializer: Api::V1::ProfileSerializer

  def replies_count
    object.comments_count
  end

  def votes_score
    object.cached_votes_score || 0
  end

  def current_vote
    return nil unless current_user
    return current_user.voted_as_when_voted_for(object)
  end
end
