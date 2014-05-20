class GameDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def name_with_stars
    h.content_tag :span, class: "game-name with-stars" do
      html = h.content_tag :span, class: 'name' do
        object.name
      end
      html += h.game_stars(object)
      html.html_safe
    end
  end

end
