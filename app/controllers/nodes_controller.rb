class NodesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_game
  before_filter :load_and_authorize_node, except: [:new, :create, :index]
  
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
  
  def set_as_first
    if SetNodeAsFirst.new(@node).call.success?
      flash[:notice] = I18n.t("statements.updated")
    else
      flash[:alert] = I18n.t("statements.failed_try_again")
    end
    redirect_to [@game, @node]
  end
  
  private
  
  def load_and_authorize_node
    @node = @game.nodes.find(params[:id])
    authorize @node
  end
  
  def load_game
    @game = Game.find(params[:game_id])
  end

  def node_params
    params.require(:node).permit(:content)
  end
end
