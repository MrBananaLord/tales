class GamesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :set_game, only: [:edit, :update, :show, :destroy]
  
  def new
    @game = current_user.games.build
    authorize @game
  end
  
  def create
    @game = current_user.games.build(game_params)
    authorize @game

    if @game.save
      redirect_to @game, notice: I18n.t("statements.created")
    else
      render action: "new"
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @game.update(game_params)
      redirect_to @game, notice: I18n.t("statements.updated")
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @game.destroy
    redirect_to current_user, notice: I18n.t("statements.destroyed")
  end
  
  private
  
  def set_game
    @game = Game.find(params[:id])
    authorize @game
  end

  def game_params
    params.require(:game).permit(:name, :description)
  end
end
