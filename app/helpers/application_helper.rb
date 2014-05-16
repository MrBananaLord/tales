module ApplicationHelper
  def action_link_to(name, url, options = {}, &block)
    condition = options[:if].nil? ? true : options[:if]
    name = capture(&block) if block_given?
    name = I18n.t("actions.#{name}") if name.class == Symbol
    options[:class] ||= "btn btn-default"
    link_to name, url, options if condition
  end
  
  def basic_actions(fields, url)
    tags = ""
    tags += fields.button :submit
    tags += content_tag(:span) do
      I18n.t("statements.or")
    end
    tags += link_to I18n.t("statements.cancel"), url
    
    content_tag(:div, class: :actions) do
      tags.html_safe
    end.html_safe
  end
end
