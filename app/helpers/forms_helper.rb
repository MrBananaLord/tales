module FormsHelper
  def panelized_page(title, &block)
    content_tag(:div, class: "panel panel-default") do
      html = content_tag(:div, class: "panel-heading") do
        content_tag(:h1, title(title))
      end
      html += content_tag(:div, class: "panel-body") do
        block.call
      end
    end
  end
end
