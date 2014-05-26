class HomeController < ApplicationController
  def index
    @most_popular_games = GameDecorator.decorate_collection(
      Game.published.by_mark.limit(3))
      
    @latest_games = GameDecorator.decorate_collection(Game.published.latest.limit(2))
    
    @most_popular_authors = User.by_mark.limit(4)
  end
end
