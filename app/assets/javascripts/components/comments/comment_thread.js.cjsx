# @cjsx React.DOM

@CommentThread = React.createClass
  componentDidMount: ()->
    @fetch_comments() if @props.autoload

  getInitialState: ()->
    comments: [],
    meta: {},
    loading: false,
    loaded: (@props.replies_count == 0),
    saving: false,
    page: 0

  fetch_comments: (page=1)->
    @setState({loading: true})

    $.ajax({
      url: '/api/v1/comments',
      data: {
        commentable_type: @props.item_type,
        commentable_id: @props.item_id,
        root_id: @props.root_comment_id,
        page: page
      }
      method: 'get',
      dataType: 'json',
      success: @comments_loaded,
      errors: @comments_load_failure
    })

  comments_load_failure: ()->
    @setState({
      loading: false
    })

  comments_loaded: (json)->
    @setState({
      loading: false,
      loaded: true,
      comments: @state.comments.concat(json.comments)
      meta: json.meta
    })


  create_comment: (comment)->
    @setState({saving: true})

    $.ajax({
      url: '/api/v1/comments',
      method: 'post',
      data: {
        comment: {
          body: comment.body,
          commentable_type: @props.item_type,
          commentable_id: @props.item_id,
          parent_id: @props.root_comment_id
        }
      },
      success: @comment_create_success,
      error: @comment_create_failure
    })

  comment_create_success: (json)->
    comments = @state.comments
    comments.unshift(json.comment)

    @setState({
      comments: comments,
      saving: false
    })


  comment_create_failure: ()->
    @setState({saving: false})


  load_replies: (e)->
    e.preventDefault()
    @fetch_comments()

  more_pages: ()->
    return false unless @state.loaded

    page =        @state.meta.page
    per_page =    @state.meta.per_page
    total_items = @state.meta.total_items

    total_items > page * per_page

  load_next_page: (e)->
    e.preventDefault()
    @fetch_comments(@state.meta.page + 1)


  comment_form: ()->
    comment_form = null
    if @state.saving
      comment_form = <div className='saving flasher'>Submitting...</div>
    else
      comment_form = <CommentForm allow_create={@props.allow_create} default_open={@props.default_open} parent_comment_id={@props.root_comment_id} on_submit={@create_comment} />

    comment_form

  paginator: ()->
    if @more_pages()
      return <li><a href='' onClick={@load_next_page}>Load more comments</a></li>

  comment_elements: ()->
    comment_elements = []
    if @state.loaded
      for comment in @state.comments
        comment_elements.push(
          <Comment comment_data={comment} allow_create={@props.allow_create} key={comment.id}  item_type={@props.item_type} item_id={@props.item_id}>
            {comment.body}
          </Comment>
        )

    return comment_elements


  render: ->
    if @state.loading
      <div className='loading flasher'>Loading...</div>
    else
      if @state.loaded
        <div>
          {@comment_form()}
          <ul className='comment_thread'>
            {@comment_elements()}
            {@paginator()}
          </ul>
        </div>
      else
        if @props.replies_count > 0
          <div>
            <div><a href='' onClick={@load_replies}>Load {@props.replies_count} Replies</a></div>
          </div>
        else
          <div>
            {@comment_form()}
          </div>
