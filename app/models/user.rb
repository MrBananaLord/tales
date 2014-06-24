class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
         
  mount_uploader :avatar, AvatarUploader
  mount_enumeration :role, Enumerations::User::Role,
                    default: "standard_user", set_default_on_initialize: true
         
  has_many :games, dependent: :destroy, foreign_key: "owner_id"
  has_many :marks, dependent: :destroy
  has_many :saves, dependent: :destroy, class_name: "Save"
  
  validates :username, uniqueness: { case_sensitive: false }
  delegate :admin?, to: :role
  
  attr_accessor :login
  
  scope :by_mark, -> {
    joins(:games).
    joins("INNER JOIN marks ON marks.game_id = games.id").
    group("users.id, games.id").
    order("AVG(marks.value) DESC")
  }
    
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
    games.by_mark.inject(0) do |sum, game|
      sum += game.average_mark
    end / ((count = games.by_mark.length) == 0 ? 1 : count)
  end
  
end
