module MarksHelper
  def stars(quantity)
    content_tag(:div, class: "stars") do
      quantity.round.times.inject("") do |html, i|
        html += content_tag(:small, "", class: "glyphicon glyphicon-star")
      end.html_safe
    end
  end
end
