class Choice < ActiveRecord::Base
  belongs_to :tail, class_name: "Paragraph"
  belongs_to :head, class_name: "Paragraph"
  
  delegate :game, to: :tail
  
  validates :tail, :content, presence: true
  validates :head, inclusion: { in: :game_paragraphs }, allow_nil: true
  
  def build_head
    super(game: game)
  end
  
  private
  
  def game_paragraphs
    game.paragraphs
  end
end
