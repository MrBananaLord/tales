class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
    
    @user_games = GamePolicy::Scope.new(current_user, @user.games).resolve
    @user_games = GameDecorator.decorate_collection @user_games
    
    @user_favorite_games = GamePolicy::Scope.new(current_user,   
                            @user.favorite_games.limit(4)).resolve
    @user_favorite_games = GameDecorator.decorate_collection @user_favorite_games
  end
end
