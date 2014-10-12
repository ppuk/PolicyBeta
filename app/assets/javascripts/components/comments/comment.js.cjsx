#= require showdown
# @cjsx React.DOM

@Comment = React.createClass
  getInitialState: ()->
    saving: false,
    replies_count: @props.comment_data.replies_count,
    autoload_replies: false

  markdown_body: ()->
    converter = new Showdown.converter()
    converter.makeHtml(@props.children)

  vote_cast: (vote_data)->

  render: ->
    comment_class = "comment comment_#{@props.comment_data.id}"

    <li className={comment_class} key={@props.comment_data.id}>
      <VoteInput callback={@vote_cast} item_id={@props.comment_data.id} item_type='comment' vote_count={@props.comment_data.votes_score} current_vote={@props.comment_data.current_vote} />
      <div className='comment-data'>
        <div className='body' dangerouslySetInnerHTML={{__html: @markdown_body()}} >
        </div>
        <div className='meta'>
          <span>{@props.comment_data.user.username}</span>
          <span>{moment(@props.comment_data.created_at).format('DD/MM/YYYY HH:mm:ss')}</span>
        </div>

        <CommentThread allow_create={@props.allow_create} item_id={@props.item_id} item_type={@props.item_type} replies_count={@state.replies_count} root_comment_id={@props.comment_data.id} autoload={@state.autoload_replies} />
      </div>
    </li>
