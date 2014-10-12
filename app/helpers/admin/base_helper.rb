module Admin::BaseHelper
  def nav_item(name, link, controller_name)
    current_class = (params[:controller].gsub(/(.*)\//, '') == controller_name) ? 'active' : ''

    content_tag('li', class: current_class) do
      link_to name, link
    end
  end
end
