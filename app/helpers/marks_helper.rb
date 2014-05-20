module MarksHelper
  def stars(quantity)
    quantity.round.times.inject("") do |html, i|
      html += content_tag(:small, "", class: "glyphicon glyphicon-star")
    end.html_safe
  end
end
