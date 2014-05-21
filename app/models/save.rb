class Save < ActiveRecord::Base
  belongs_to :user
  belongs_to :paragraph
  belongs_to :game
end
