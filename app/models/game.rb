class Game < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :first_node, class_name: "Node"
  has_many :nodes, dependent: :destroy
  has_many :edges, through: :nodes, source: :children_edges
  
  validates :name, presence: true
  
  def published?
    published_at.present?
  end
  
  def publish!
    update_column(:published_at, Time.now)
  end
end
