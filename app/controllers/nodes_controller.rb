class NodesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_game
  before_filter :set_node, only: [:edit, :update, :show, :destroy]
  
  def new
    @node = @game.nodes.build
    authorize @node
  end
  
  def create
    @node = @game.nodes.build(node_params)
    authorize @node

    if @node.save
      redirect_to [@game, @node], notice: I18n.t("statements.created")
    else
      render action: "new"
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @node.update(node_params)
      redirect_to [@game, @node], notice: I18n.t("statements.updated")
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @node.destroy
    redirect_to @game, notice: I18n.t("statements.destroyed")
  end
  
  def index
    authorize @game, :edit?
    @nodes = @game.nodes
  end
  
  private
  
  def set_node
    @node = Node.find(params[:id])
    authorize @node
  end
  
  def load_game
    @game = Game.find(params[:game_id])
  end

  def node_params
    params.require(:node).permit(:content)
  end
end
