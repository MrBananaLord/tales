class Edge < ActiveRecord::Base
  belongs_to :tail, class_name: "Node"
  belongs_to :head, class_name: "Node"
  
  delegate :game, to: :tail
  
  validates :tail, :content, presence: true
  validates :head, inclusion: { in: :game_nodes }, allow_nil: true
  
  private
  
  def game_nodes
    game.nodes
  end
end
