class HomeController < ApplicationController
  def index
    @most_popular_games = GameDecorator.decorate_collection(
      Game.published.ordered_by_average_mark.limit(4))
      
    @latest_games = GameDecorator.decorate_collection(Game.published.latest.limit(4))
  end
end
