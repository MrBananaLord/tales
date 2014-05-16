class Choice < ActiveRecord::Base
  belongs_to :parent_paragraph, class_name: "Paragraph"
  belongs_to :child_paragraph, class_name: "Paragraph"
  
  delegate :game, to: :parent_paragraph
  
  validates :parent_paragraph, :content, presence: true
  validates :child_paragraph, inclusion: { in: :game_paragraphs }, allow_nil: true
  
  def build_head
    super(game: game)
  end
  
  private
  
  def game_paragraphs
    game.paragraphs
  end
end
