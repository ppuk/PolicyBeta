module VotesHelper

  def vote_input(item, user)
    vote_data = {
      item_type: item.class.object_class.name.underscore,
      item_id: item.id,
      behavior: 'vote-input',
      vote_count: item.cached_votes_score,
      current_vote: signed_in? ? current_user.voted_as_when_voted_for(item) : nil
    }

    content_tag(:div, '', class: 'vote', data: vote_data)
  end

end

