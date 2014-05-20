class ParagraphsController < ApplicationController
  
  before_filter :load_game
  before_filter :load_choice, only: [:new, :create]
  before_filter :load_and_authorize_paragraph, except: [:new, :create, :index]
  before_filter :set_filter, only: :index
  
  layout "game"
  
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
    @parent_choices = ParentChoicePolicy::Scope.new(current_user,
      @paragraph.parent_choices).resolve
    @children_choices = ChildrenChoicePolicy::Scope.new(current_user,
      @paragraph.children_choices).resolve
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
    @paragraphs = @game.paragraphs.send(@filter.value)
  end
  
  def set_as_first
    if SetParagraphAsFirstService.new(@paragraph).call.success?
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
  
  def set_filter
    filter_name = if params[:filter].in?(Paragraph.filters.map(&:value))
      params[:filter]
    else
      :all
    end
    @filter = Filter.new(Paragraph, filter_name)
  end
end
