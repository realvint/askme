module ApplicationHelper
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fas fa-#{icon_class}"
  end
end
