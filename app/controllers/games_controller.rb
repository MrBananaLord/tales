class GamesController < ApplicationController  
  before_filter :load_game, only: [:edit, :update, :show,
                                   :destroy, :publish]
                                   
  include GameBase
                                                 
  before_filter :load_mark, except: [:destroy, :new, :create]
  layout "game", except: [:destroy, :new, :create, :show]
  
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
  
  def publish
    @game.update_column :published_at, Time.now
    redirect_to @game, notice: I18n.t("statements.published")
  end
  
  private
  
  def load_game
    @game = GameDecorator.decorate Game.find(params[:id])
    authorize @game
  end

  def game_params
    params.require(:game).permit(:name, :description)
  end
  
  
end
