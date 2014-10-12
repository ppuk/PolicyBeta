#= require_tree ./comments

# @cjsx React.DOM

@CommentBox = React.createClass

  render: ->
    <div className='comments'>
      <CommentThread default_open={@props.default_open} autoload={@props.default_open} allow_create={@props.allow_create} item_type={@props.item_type} item_id={@props.item_id} replies_count={@props.replies_count} />
    </div>


$ ->
  for elem in $('[data-behavior=comments]')
    React.renderComponent(
      <CommentBox default_open={$(elem).data('default-open')} allow_create={$(elem).data('allow-create')} item_id={$(elem).data('item-id')} item_type={$(elem).data('item-type')} replies_count={$(elem).data('replies-count')} />,
      elem
    )
