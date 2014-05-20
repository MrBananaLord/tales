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
  
  def hamburger_toggler
    # TODO translate
    content_tag(:span, "Toggle navigation", class: "sr-only") + hamburger
  end
  
  def hamburger
    3.times.inject("") do |html, i|
      html += content_tag(:span, "", class: "icon-bar")
    end.html_safe
  end
  
  def panelized_page(title)
    content_tag(:div, class: "panel panel-default") do
      html = content_tag(:div, class: "panel-heading") do
        content_tag(:h1, title(title))
      end
      html += content_tag(:div, class: "panel-body") do
        yield
      end
    end
  end
  
  def caret_menu
    content_tag(:div, class: "btn-group pull-right") do
      html = content_tag(:div, data: { toggle: :dropdown },
                         class: "btn btn-default dropdown-toggle") do
        content_tag(:span, "", class: "caret")
      end
      html += content_tag(:ul, class: "dropdown-menu") do
        yield
      end
      html.html_safe
    end
  end
end
