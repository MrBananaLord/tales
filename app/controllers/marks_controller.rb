class MarksController < ApplicationController
  include GameBase
  before_filter :store_location
  before_filter :authorize_game
  
  def create
    redirect_to session[:pre_mark_url] || @game, after_mark_notification
  end
  
  def update
    redirect_to session[:pre_mark_url] || @game, after_mark_notification
  end
  
  private
  
  def mark_params
    params.require(:mark).permit(:value)
  end  
  
  def after_mark_notification
    if mark_game_service.call.success?
      { notice: [flash[:notice], I18n.t("marks.controller.game_marked")].join(" ") }
    else
      { alert: I18n.t("marks.controller.marking_game_failed") }
    end
  end
  
  def mark_game_service
    @mark_game_service ||= User::MarkGameService.new(current_user, @game,
                                                     mark_params[:value])
  end
  
  def authorize_game
    authorize @game, :mark?
  end
  
  def store_location
    if session[:previous_url] != game_mark_path(@game, mark: mark_params)
      session[:pre_mark_url] = session[:previous_url]
      session[:previous_url] = game_mark_path(@game, mark: mark_params)
    end
  end
end
