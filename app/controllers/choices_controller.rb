class ChoicesController < ApplicationController
  
  before_filter :load_game
  before_filter :load_paragraph
  before_filter :load_and_authorize_choice, only: [:edit, :update, :destroy]
  
  def new
    @choice = @paragraph.children_choices.build
    authorize @choice
  end
  
  def create
    @choice = @paragraph.children_choices.build(choice_params)
    authorize @choice

    if @choice.save
      redirect_to [@game, @paragraph], notice: I18n.t("statements.created")
    else
      render action: "new"
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @choice.update(choice_params)
      redirect_to [@game, @paragraph], notice: I18n.t("statements.updated")
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @choice.destroy
    redirect_to @paragraph, notice: I18n.t("statements.destroyed")
  end
  
  private
  
  def load_and_authorize_choice
    @choice = @paragraph.children_choices.find(params[:id])
    authorize @choice
  end
  
  def load_game
    @game = Game.find(params[:game_id])
  end
  
  def load_paragraph
    @paragraph = @game.paragraphs.find(params[:paragraph_id])
  end

  def choice_params
    params.require(:choice).permit(:content, :child_paragraph_id)
  end
end
