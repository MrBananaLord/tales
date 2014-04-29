class SetParagraphAsFirst
  def initialize(paragraph)
    @success = true
    @paragraph = paragraph
    @game = paragraph.game
  end
  
  def call
    @success = @paragraph.id.present? ? set_as_first : false
    self
  end
  
  def success?
    !!@success
  end
  
  private
  
  def set_as_first
    @game.update_column(:first_paragraph_id, @paragraph.id)
  end
end
