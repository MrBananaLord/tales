class GamePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
  end
  
  def new?
    user.present?
  end
  
  private
  
  def manage?
    user == record.owner
  end
  
  def read?
    user == record.owner || record.published?
  end
end
