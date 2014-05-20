class HomeController < ApplicationController
  def index
    @most_popular_games = GameDecorator.decorate_collection(
      GamePolicy::Scope.new(current_user, Game.ordered_by_average_mark).
      resolve.limit(4))
      
    @latest_games = GameDecorator.decorate_collection(
      GamePolicy::Scope.new(current_user, Game.latest).resolve.limit(4))
  end
end
