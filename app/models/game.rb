class Game < ActiveRecord::Base
  belongs_to :owner
  belongs_to :first_node
end
