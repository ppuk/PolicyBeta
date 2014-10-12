$ ->
  for element in $('form[data-auto-submit="true"]')
    $(element).find('select').on('change', (()->
      element.submit()
    ))

