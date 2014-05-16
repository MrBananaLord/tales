class Paragraph < ActiveRecord::Base
  belongs_to :game
  has_many :children_choices, foreign_key: :parent_paragraph_id,
           class_name: "Choice", dependent: :destroy
  has_many :children_paragraphs, through: :children_choices, source: :child_paragraph
  has_many :parent_choices, foreign_key: :child_paragraph_id, class_name: "Choice"
  has_many :parent_paragraphs, through: :parent_choices, source: :parent_paragraph
  
  accepts_nested_attributes_for :parent_choices
  
  validates :game, :content, presence: true
end
