class MarksController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_game
  
  def create
    redirect_to (session[:previous_url] || @game), after_mark_notification
  end
  
  def update
    redirect_to (session[:previous_url] || @game), after_mark_notification
  end
  
  private
  
  def load_game
    @game = Game.find(params[:game_id])
    authorize @game, :mark?
  end

  def mark_params
    params.require(:mark).permit(:value)
  end  
  
  def after_mark_notification
    if mark_game_service.call.success?
      { notice: I18n.t(".game_marked") }
    else
      { alert: I18n.t(".marking_game_failed") }
    end
  end
  
  def mark_game_service
    @mark_game_service ||= User::MarkGameService.new(current_user, @game, mark_params)
  end
end
