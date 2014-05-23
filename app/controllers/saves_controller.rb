class SavesController < ApplicationController
  include GameBase
  before_filter :authenticate_user!, only: [:index, :destroy]
  before_filter :load_game, only: :create
  before_filter :load_mark, only: :create
  before_filter :load_save, only: :create
  before_filter :load_paragraph, only: :create
  before_filter :store_location
  
  layout "game", except: :index
  
  def create
    authorize @game, :save?
    @save = find_or_initialize_save
    if @save.persisted? && !params[:confirm]
      render :confirmation
    else
      @save.paragraph = @paragraph
      if @save.save
        redirect_to [@game, @paragraph],
          notice: [flash[:notice], I18n.t("saves.controller.game_saved")].join(" ")
      else
        redirect_to [@game, @paragraph],
          alert: I18n.t("saves.controller.saving_game_failed")
      end
    end
  end
  
  def index
    @saves = current_user.saves
  end
  
  def destroy
    @save = current_user.saves.find(params[:id])
    authorize @save
    @save.destroy
    redirect_to saves_index_path, notice: I18n.t(".statements.destroyed")
  end
  
  private
  
  def find_or_initialize_save
    Save.find_or_initialize_by(user_id: current_user.id, game_id: @game.id)
  end
  
  def load_paragraph
    @paragraph = @game.paragraphs.find(params[:id])
  end
end
