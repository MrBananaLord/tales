class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :games, dependent: :destroy, foreign_key: "owner_id"
end
