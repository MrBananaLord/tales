class Game < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :first_paragraph, class_name: "Paragraph"
  has_many :paragraphs, dependent: :destroy
  has_many :choices, through: :paragraphs, source: :children_choices
  has_many :marks
  
  validates :name, presence: true
  
  scope :published, -> { where("published_at < ?", Time.now) }
  scope :by_mark, -> { joins(:marks).group("games.id").
    order("(sum(marks.value) / count(marks.id)) DESC, count(marks.id) DESC") }
  scope :latest, -> { order("published_at DESC") }
  
  def published?
    published_at.present?
  end
  
  def publish!
    update_column(:published_at, Time.now)
  end
  
  def average_mark
    marks.map(&:value).inject(0) do |sum, value|
      sum + value.value
    end / ((count = marks.count) == 0 ? 1 : count )
  end
end
