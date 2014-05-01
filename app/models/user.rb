class User < ActiveRecord::Base
  attr_accessor :login

  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
         
  has_many :games, dependent: :destroy, foreign_key: "owner_id"
  
  validates :username, uniqueness: { case_sensitive: false }
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  def needs_password?
    provider_type.nil?
  end
end
