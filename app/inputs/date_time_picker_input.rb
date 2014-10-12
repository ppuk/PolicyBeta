class DateTimePickerInput <  SimpleForm::Inputs::StringInput
  def value
    @value ||= object.send(attribute_name).try(:to_time)
  end

  def formatted_value
    I18n.l(value.localtime, format: :form) if value
  end

  def control_id
    [object.class.to_s.underscore, attribute_name].join('_')
  end

  def element_attributes
    {
      type: 'text',
      class: 'form-control',
      value: formatted_value,
      id: control_id,
      data: {
        date_format: 'DD/MM/YYYY HH:mm'
      }
    }
  end

  def input
    submit_value = value ? value.iso8601 : ''

    template.content_tag(:div, class: 'datepicker') do
      @builder.hidden_field(attribute_name, value: submit_value, class: 'submittable_field') +
      template.content_tag(:div, class: 'input-group input-append date') do
        template.tag(:input, element_attributes) +
        template.content_tag(:span, class: 'input-group-addon') do
          template.tag(:span, class: 'glyphicon glyphicon-calendar')
        end
      end
    end
  end
end

