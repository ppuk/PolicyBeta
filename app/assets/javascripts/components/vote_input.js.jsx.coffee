###* @jsx React.DOM ###

R = React.DOM

@VoteInput = React.createClass
  getInitialState: ->
    saving: false

  send_vote: (vote_type)->
    @setState({saving: true})
    $.ajax(
      method: 'post',
      url: '/api/v1/votes',
      data: {
        id: @props.item_id,
        type: @props.item_type,
        upvote: vote_type
      },
      success: @update_votes,
      error: @vote_failed,
      statusCode: {
        403: @unauthorized_error
      }
    )

  unauthorized_error: ()->
    alert 'Please log in first'

  update_votes: (json)->
    @props.vote_count = json.vote.votable.votes_score
    @props.current_vote = json.vote.vote_flag
    @setState({saving: false})
    @props.callback(json.vote) if @props.callback

  vote_failed: (jqXHR, textStatus, error)->
    @setState({saving: false})

  upvote: ()->
    @send_vote(true)
    false

  downvote: ()->
    @send_vote(false)
    false

  render: ->
    upvote_class = 'upvote'
    downvote_class = 'downvote'

    if @props.current_vote == true
      upvote_class += ' selected'

    if @props.current_vote == false
      downvote_class += ' selected'

    if @state.saving
      return R.div className:'vote_state',
        R.a href:'', className:upvote_class, onClick:@upvote,
          R.i className:'fa fa-caret-up'
        R.span className:'vote_total flasher', @props.vote_count
        R.a href:'', className:downvote_class, onClick:@downvote,
          R.i className:'fa fa-caret-down'
    else
      return R.div className:'vote_state',
        R.a href:'', className:upvote_class, onClick:@upvote,
          R.i className:'fa fa-caret-up'
        R.span className:'vote_total', @props.vote_count
        R.a href:'', className:downvote_class, onClick:@downvote,
          R.i className:'fa fa-caret-down'

$ ->
  for elem in $('[data-behavior=vote-input]')
    React.renderComponent(
      `<VoteInput current_vote={$(elem).data('current-vote')} item_id={$(elem).data('item-id')} item_type={$(elem).data('item-type')} vote_count={$(elem).data('vote-count')}/>`,
      elem
    )
