class EdgesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_game
  before_filter :set_edge, only: [:edit, :update, :show, :destroy]
  
  def new
    @edge = @game.edges.build
    authorize @edge
  end
  
  def create
    @edge = @game.edges.build(edge_params)
    authorize @edge

    if @edge.save
      redirect_to [@game, @edge], notice: I18n.t("statements.created")
    else
      render action: "new"
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @edge.update(edge_params)
      redirect_to @edge, notice: I18n.t("statements.updated")
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @edge.destroy
    redirect_to @game, notice: I18n.t("statements.destroyed")
  end
  
  private
  
  def set_edge
    @edge = Edge.find(params[:id])
    authorize @edge
  end
  
  def load_game
    @game = Game.find(params[:game_id])
  end

  def edge_params
    params.require(:edge).permit(:content)
  end
end
