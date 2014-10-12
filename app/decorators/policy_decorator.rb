require 'html/sanitizer'

class PolicyDecorator < BaseDecorator
  include MarkdownHelper

  decorates_association :category
  decorates_association :submitter
  decorates_association :evidence_items

  def shortened_description
    sanitizer = HTML::FullSanitizer.new
    sanitizer.sanitize(markdown(object.description)).truncate(140)
  end

  def tags_list
    h.content_tag(:ul, class: 'tag-list') do
      object.tags.each do |tag|
        h.concat h.content_tag(:li, tag.name, class: 'tm-tag')
      end
    end
  end

  def state_badge
    h.content_tag(:div, class: "btn btn-xs #{object.state}") do
      I18n.t(object.state, scope: 'activerecord.attributes.policy.states')
    end
  end
end
