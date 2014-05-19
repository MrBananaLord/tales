class User::MarkGameService
  def initialize(user, game, mark_params)
    @success = true
    @user = user
    @game = game
    @mark_params = mark_params
  end
  
  def call
    mark.assign_attributes(@mark_params)
    @success = mark.save
    self
  end
  
  def success?
    !!@success
  end
  
  def mark
    @mark ||= Mark.find_or_initialize_by(user: @user, game: @game)
  end
end
