module GamesHelper
  def game_header
    content_tag(:h1) do
      link_to(title(@game.name), @game) + stars(@game.average_mark)
    end
  end
end
