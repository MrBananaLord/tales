class GamesController < ApplicationController  
  include GameBase
  before_filter :load_game, only: [:edit, :update, :show,
                                   :destroy, :publish]
                                                 
  before_filter :load_mark, except: [:destroy, :new, :create]
  layout "game", except: [:destroy, :new, :create, :show, :index]
  
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

  def index
    load_search_params
    @games = GameDecorator.decorate_collection(index_games_collection)
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
  
  def load_search_params
    @search_params = {}
    @search_params[:q] = params[:q] if params[:q]
    @search_params[:order] = params[:order] == "latest" ? "latest" : "by_mark"
  end
  
  def index_games_collection
    games = Game.published
    games = games.where(query_for_search) if @search_params[:q].present?
    games = games.send(@search_params[:order])
    games.page(params[:page]).per(10)
  end
  
  def query_for_search
    query = "name LIKE ?"
    words = @search_params[:q].split(" ").map{ |word| "%#{word}%"}
    (words.length - 1).times{ query += " OR ?"}
    [query] + words
  end
end
