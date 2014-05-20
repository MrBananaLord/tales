module GamesHelper
  def game_header
    content_tag(:h1) do
      link_to(title(@game.name), @game) + game_stars(@game)
    end
  end
  
  def game_stars(game)
    game.average_mark.round.times.inject("") do |html, i|
      html += content_tag(:small, "", class: "glyphicon glyphicon-star")
    end.html_safe
  end
  
  private
    
  #  def star_classes(value)
  #    classes = %w(glyphicon glyphicon-star)
  #    classes << "text-info" if @game.average_mark.round > value
  #    classes.compact.join(" ")
  #  end
end
