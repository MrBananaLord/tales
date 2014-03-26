class Node < ActiveRecord::Base
  belongs_to :game
  has_many :children_edges, foreign_key: :tail_id, class_name: "Edge"
  has_many :successors, through: :children_edges, source: :head
  has_many :parent_edges, foreign_key: :head_id, class_name: "Edge"
  has_many :predecessors, through: :parent_edges, source: :tail
end
