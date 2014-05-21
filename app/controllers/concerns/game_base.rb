module GameBase
  extend ActiveSupport::Concern
  
  included do  
    before_filter :load_game
    before_filter :load_mark
    before_filter :load_save
    
    layout "game"
  end
  
  private
  
  def load_mark
    @mark = Mark.find_or_initialize_by(user_id: current_user.try(:id),
                                       game_id: @game.try(:id))
  end
  
  def load_game
    @game = Game.find(params[:game_id])
  end
  
  def load_save
    @save = Save.find_by(user_id: current_user.try(:id),
                         game_id: @game.try(:id))
  end
end
