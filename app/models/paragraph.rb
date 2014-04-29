class Paragraph < ActiveRecord::Base
  belongs_to :game
  has_many :children_choices, foreign_key: :tail_id, class_name: "Choice",
           dependent: :destroy
  has_many :successors, through: :children_choices, source: :head
  has_many :parent_choices, foreign_key: :head_id, class_name: "Choice"
  has_many :predecessors, through: :parent_choices, source: :tail
  
  accepts_nested_attributes_for :parent_choices
  
  validates :game, :content, presence: true
end
