class Paragraph < ActiveRecord::Base
  include Filters
  set_filters :all, :final, :unassigned, :with_childless_choices
  
  belongs_to :game
  has_many :children_choices, foreign_key: :parent_paragraph_id,
           class_name: "Choice", dependent: :destroy
  has_many :children_paragraphs, through: :children_choices, source: :child_paragraph
  has_many :parent_choices, foreign_key: :child_paragraph_id, class_name: "Choice"
  has_many :parent_paragraphs, through: :parent_choices, source: :parent_paragraph
  has_many :saves, dependent: :destroy, class_name: "Save"
  
  accepts_nested_attributes_for :parent_choices
  
  scope :final, -> {
    not_beginning.
    includes(:children_choices).
    where(choices: { parent_paragraph_id: nil }) }
  scope :not_beginning, -> {
    joins(:game).
    where("paragraphs.id != games.first_paragraph_id") }
  scope :unassigned, -> {
    includes(:parent_choices).
    where(choices: { child_paragraph_id: nil }).
    not_beginning }
  scope :with_childless_choices, -> {
    joins(:children_choices).
    where(choices: { child_paragraph_id: nil }).
    group("paragraphs.id") }
  
  validates :game, :content, presence: true

  def final?
    children_choices.empty?
  end
  
end
