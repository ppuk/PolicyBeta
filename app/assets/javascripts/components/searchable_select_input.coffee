class @SearchableSelectInput
  constructor: (@container)->
    @setup_interface()
    @apply_event_handlers()

  setup_interface: ()->
    @container.find('ul').hide()
    @text_input = $(@container.find('input.input_filter'))
    @endpoint = @container.data('endpoint')
    @display_attribute = @container.data('display-attribute')
    @instances_key = @container.data('instances-key')

  apply_event_handlers: ()->
    @text_input.keyup((evt)=>
      query_params = {
        search: {
          query: @text_input.val() + '*'
        }
      }

      $.get(@endpoint, query_params, ((response)=>
          html = ''
          instances = response[@instances_key]


          if instances.length == 0
            html = '<li>Nothing found</li>'
          else
            for instance in instances
              html += "<li data-id-value='" + instance['id'] + "'>" + instance[@display_attribute] + "</li>"

          @container.find('ul').show()
          @container.find('ul').html(html)
        )
      )
    )

    $(document).on('click', '.filterable_select ul li', (evt)=>
      elem = $(evt.target)
      @container.find('input.id_field').val(elem.data('id-value')).trigger('change')
      @container.find('.current_selection').html(elem.html())
      @container.find('ul').hide()
      @container.find('input.input_filter').val('')
    )


$ ->
  for element in $(".filterable_select")
    new SearchableSelectInput($(element))
