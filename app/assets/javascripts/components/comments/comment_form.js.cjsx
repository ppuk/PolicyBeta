#= require ../markdown-editor
# @cjsx React.DOM

@CommentForm = React.createClass
  getInitialState: ()->
    replying: !!@props.default_open

  apply_markdown: ()->
    if @state.replying
      element = $(this.getDOMNode()).find("textarea[data-behavior='markdown']")
      new MarkdownInput(element)

  componentDidMount: ()->
    @apply_markdown()

  componentDidUpdate: ()->
    @apply_markdown()

  handleSubmit:(e)->
    e.preventDefault()
    body = @refs.body.getDOMNode().value.trim()

    if !body
      return

    @props.on_submit({
      body: body
    })

    @refs.body.getDOMNode().value = ''

  toggle_replying: (e)->
    e.preventDefault()
    @setState({replying: !@state.replying})

  render: ->
    if @props.allow_create
      if @state.replying
        return <form className="comment_form" onSubmit={@handleSubmit}>
          <textarea data-behavior="markdown" placeholder="Say something..." ref='body'>
          </textarea>
          <div>
            <a className='btn btn-danger pull-right' onClick={@toggle_replying}>Cancel</a>
            <input className='btn btn-success' type="submit" value="Post" />
          </div>
        </form>
      else
        return <a href='' onClick={@toggle_replying}>Reply</a>
    else
      return <div />

