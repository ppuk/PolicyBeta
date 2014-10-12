class SearchableSelectInput <  SimpleForm::Inputs::FileInput

  # :endpoint is the url to us when requesting the list
  def endpoint
    @endpoint ||= input_html_options.delete(:endpoint)
  end

  def display_attribute
    @display_attribute ||= input_html_options.delete(:display_attribute) || raise('display_attribute is not specified')
  end

  def association_name
    @association_name ||= input_html_options.delete(:association_name) || raise('association_name is not specified')
  end

  def instances_key
    @instances_key ||= input_html_options.delete(:instances_key) || raise('instances_key is not specified')
  end

  def element_attributes
    {
      class: 'filterable_select',
      'data-endpoint' => endpoint,
      'data-display-attribute' => display_attribute,
      'data-instances-key' => instances_key
    }
  end

  def association_value
    return nil unless object.send(association_name) && object.send(association_name).send(display_attribute)
    @association_value ||= object.send(association_name).send(display_attribute)
  end

  def input
    template.content_tag(:div, element_attributes) do
      @builder.hidden_field(attribute_name, class: 'id_field') +
      template.content_tag(:div, association_value || 'None selected', class: 'current_selection') +
      template.tag(:input, type: 'text', class: 'input_filter', placeholder: 'Search') +
      template.content_tag(:ul, '')
    end
  end
end
