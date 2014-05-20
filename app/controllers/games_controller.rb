class GamesController < ApplicationController
  
  before_filter :load_and_authorize_game, only: [:edit, :update, :show,
                                                 :destroy, :publish]
  
  layout "game", except: [:destroy, :new, :create]
  
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
    @mark = Mark.find_or_initialize_by(user_id: current_user.try(:id), game: @game)
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
  
  def publish
    @game.update_column :published_at, Time.now
    redirect_to @game, notice: I18n.t("statements.published")
  end
  
  private
  
  def load_and_authorize_game
    @game = Game.find(params[:id])
    authorize @game
  end

  def game_params
    params.require(:game).permit(:name, :description)
  end
end
