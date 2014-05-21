class GameDecorator < Draper::Decorator
  delegate_all

  def name_with_stars
    h.content_tag :span, class: "game-name with-stars" do
      html = h.content_tag :span, class: 'name' do
        game_name
      end
      html += h.stars(object.average_mark)
      html.html_safe
    end
  end
  
  private
  
  def game_name
    if object.published?
      object.name
    else
      "#{object.name} (#{I18n.t("games.decorator.draft").downcase})"
    end
  end

end
