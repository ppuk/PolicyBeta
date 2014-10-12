class CategoryDecorator < BaseDecorator

  def contrasting_color
    colour = object.colour.blank? ? '#ffffff' : object.colour
    (colour[1..-1].scan(/../).map {|colour| colour.hex}).sum > 382.5 ? '#000' : '#fff'
  end

  def name_badge
    h.content_tag(:span, object.name, class: 'btn btn-xs', style: "background-color: #{object.colour}; color: #{contrasting_color}")
  end

end
