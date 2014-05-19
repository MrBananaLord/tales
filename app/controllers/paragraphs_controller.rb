class ParagraphsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_game
  before_filter :load_choice, only: [:new, :create]
  before_filter :load_and_authorize_paragraph, except: [:new, :create, :index]
  before_filter :set_scope, only: :index
  
  def new
    @paragraph = @game.paragraphs.build(parent_choices: parent_choices)
    authorize @paragraph
  end
  
  def create
    @paragraph = @game.paragraphs.build(paragraph_params.merge(parent_choices: parent_choices))
    authorize @paragraph

    if @paragraph.save
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
    if @paragraph.update(paragraph_params)
      redirect_to [@game, @paragraph], notice: I18n.t("statements.updated")
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @paragraph.destroy
    redirect_to @game, notice: I18n.t("statements.destroyed")
  end
  
  def index
    authorize @game, :edit?
    @paragraphs = @game.paragraphs.send(@scope)
  end
  
  def set_as_first
    if SetParagraphAsFirst.new(@paragraph).call.success?
      flash[:notice] = I18n.t("statements.updated")
    else
      flash[:alert] = I18n.t("statements.failed_try_again")
    end
    redirect_to game_paragraphs_path(@game)
  end
  
  private
  
  def load_and_authorize_paragraph
    @paragraph = @game.paragraphs.find(params[:id])
    authorize @paragraph
  end
  
  def load_game
    @game = Game.find(params[:game_id])
  end

  def paragraph_params
    params.require(:paragraph).permit(:content)
  end
  
  def parent_choices
    @parent_choices ||= [@choice].compact
  end
  
  def load_choice
    @choice = @game.choices.find_by(id: params[:choice_id])
  end
  
  def set_scope
    @scope = if params[:filter].in?(Paragraph::FILTERS)
      params[:filter].to_sym
    else
      :all
    end
  end
end
