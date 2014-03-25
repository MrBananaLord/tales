class Node < ActiveRecord::Base
  belongs_to :game
  has_many :children_edges, foreign_key: "tail_id", class_name: "Edge"
end
