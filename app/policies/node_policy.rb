class NodePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
  end
  
  private
  
  def manage?
    user == record.game.owner
  end
  
  def read?
    user == record.game.owner || record.game.published?
  end
end
