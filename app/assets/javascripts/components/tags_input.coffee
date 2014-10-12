class @TagsInput
  constructor: (@tags_field)->
    @setup_elements()
    @apply_tag_manager()
    @apply_typeahead()

  setup_elements: ()->
    @tags_field.parent().addClass('tag-select')
    @input_field = $('<input type="text" class="tm-tag" />')
    @tags_field.attr('type', 'hidden')
    @input_field.insertAfter(@tags_field)

  apply_tag_manager: ()->
    @tags_manager = @input_field.tagsManager({
      prefilled: @tags_field.val().split(', '),
      output: @tags_field
    })

    @input_field.data('tagsManager', @tagsManager)

  apply_typeahead: ()->
    @setup_bloodhound()
    @typeahead = @input_field.typeahead(null, {
      source: @bloodhound.ttAdapter(),
      displayKey: ((suggestion)->
        suggestion.tags.name
      )
    })

    @typeahead.on('typeahead:selected', @select_suggestion)

  select_suggestion: (e, suggestion)=>
    @input_field.tagsManager('pushTag', suggestion.tags.name)

  setup_bloodhound: ->
    @bloodhound = new Bloodhound({
      name: 'tags',
      remote: {
        url: '/api/v1/tags?query=%QUERY',
        filter: ((r)->
          r.tags
        )
      },
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      datumTokenizer: Bloodhound.tokenizers.whitespace
    })

    @bloodhound.initialize()

$ ->
  for element in $("[data-behavior=tags-input]")
    new TagsInput($(element))
