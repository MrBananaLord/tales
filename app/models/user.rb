class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
         
  mount_uploader :avatar, AvatarUploader
         
  has_many :games, dependent: :destroy, foreign_key: "owner_id"
  has_many :marks, dependent: :destroy
  
  validates :username, uniqueness: { case_sensitive: false }
  
  attr_accessor :login
  
  scope :by_mark, -> { joins(:marks).group("users.id").
    order("(sum(marks.value) / count(marks.id)) DESC, count(marks.id) DESC") }
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
    
  def nickname
    username || email.split("@").first
  end
  
  def favorite_games
    games.by_mark
  end

  def average_mark
    if games.count > 0
      games.inject(0) do |sum, game|
        sum += game.average_mark
      end / games.count
    else
      0
    end
  end
  
end
