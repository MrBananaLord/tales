module GamesHelper
  def game_header
    content_tag(:h1) do
      link_to(@game.name_with_stars, @game)
    end
  end
end
