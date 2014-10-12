#= require moment
#= require bootstrap-datetimepicker

class @DatePickerInput
  constructor: (@container)->
    @setup_interface()
    @setup_event_handlers()

  setup_interface: ()->
    @submittable_date = @container.find('.submittable_field')
    @input_control = @container.find('.input-group.date')
    @form_control = @container.find('.form-control')

    @dp = @input_control.datetimepicker({
      defaultDate: moment(@submittable_date.val())
    })

  setup_event_handlers: ()->
    @form_control.on('change', @convert_time)
    @dp.on('dp.change', @convert_time)

  # The date picker value is not submitted directly - we first
  # convert to iso8601 and submit the hidden field
  convert_time: ()=>
    elem = @container.find('.form-control')
    formatted_date = ''

    if elem.val()
      date = moment(elem.val(), 'DD/MM/YYYY HH:mm')
      formatted_date = date.utc().format("YYYY-MM-DDTHH:mm:ss.SSSZZ")

    @submittable_date.val(formatted_date)

$ ->
  for element in $(".datepicker")
    new DatePickerInput($(element))
