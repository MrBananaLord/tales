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
    true
  end
end
