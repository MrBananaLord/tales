class Save < ActiveRecord::Base
  self.table_name = "saves"
  belongs_to :user
  belongs_to :paragraph
  belongs_to :game
end
