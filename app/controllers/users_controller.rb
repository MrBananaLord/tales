class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
    
    @user_games = GamePolicy::Scope.new(current_user, @user.games).resolve
    @user_games = GameDecorator.decorate_collection @user_games
  end
end
