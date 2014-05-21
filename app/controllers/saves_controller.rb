class SavesController < ApplicationController
  include GameBase
  before_filter :load_paragraph
  before_filter :store_location
  
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
  
  private
  
  def find_or_initialize_save
    Save.find_or_initialize_by(user: current_user, game: @game)
  end
  
  def load_paragraph
    @paragraph = @game.paragraphs.find(params[:id])
  end
end
