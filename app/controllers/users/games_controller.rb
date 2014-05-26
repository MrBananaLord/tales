class Users::GamesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @games = GameDecorator.decorate_collection(
      GamePolicy::Scope.new(current_user, @user.games).resolve.
      page(params[:page]).per(10))
  end
end
