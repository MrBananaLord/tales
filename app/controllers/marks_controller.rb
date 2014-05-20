class MarksController < ApplicationController
  include GameBase
  
  def create
    redirect_to session[:previous_url] || @game, after_mark_notification
  end
  
  def update
    redirect_to session[:previous_url] || @game, after_mark_notification
  end
  
  private
  
  def mark_params
    params.require(:mark).permit(:value)
  end  
  
  def after_mark_notification
    if mark_game_service.call.success?
      { notice: I18n.t("marks.controller.game_marked") }
    else
      { alert: I18n.t("marks.controller.marking_game_failed") }
    end
  end
  
  def mark_game_service
    @mark_game_service ||= User::MarkGameService.new(current_user, @game,
                                                     mark_params[:value])
  end
end
