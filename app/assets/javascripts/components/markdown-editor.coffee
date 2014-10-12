#= require bootstrap-markdown-bundle

class @MarkdownInput
  constructor: (@element)->
    @setup_interface()

  setup_interface: ()->
    @element.markdown({
      iconlibrary: 'fa'
    })

$ ->
  for element in $("textarea[data-behavior='markdown']")
    new MarkdownInput($(element))

