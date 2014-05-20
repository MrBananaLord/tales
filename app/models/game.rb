class Game < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :first_paragraph, class_name: "Paragraph"
  has_many :paragraphs, dependent: :destroy
  has_many :choices, through: :paragraphs, source: :children_choices
  has_many :marks
  
  validates :name, presence: true
  
  scope :published, -> { where("published_at < ?", Time.now) }
  
  def published?
    published_at.present?
  end
  
  def publish!
    update_column(:published_at, Time.now)
  end
  
  def average_mark
    if marks.any?
      marks.pluck(:value).inject{ |sum, value| sum + value } / marks.count
    else
      0
    end
  end
end
