class User::MarkGameService
  def initialize(user, game, value)
    @success = true
    @user = user
    @game = game
    @value = value.to_i
  end
  
  def call
    mark.value = @value
    @success = mark.save
    self
  end
  
  def success?
    !!@success
  end
  
  def mark
    @mark ||= Mark.find_or_initialize_by(user_id: @user.id, game_id: @game.id)
  end
end
