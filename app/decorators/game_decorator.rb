class GameDecorator < Draper::Decorator
  delegate_all

  def name_with_stars
    h.content_tag :span, class: "game-name with-stars" do
      html = h.content_tag :span, class: 'name' do
        object.name
      end
      html += h.stars(object.average_mark)
      html.html_safe
    end
  end

end
