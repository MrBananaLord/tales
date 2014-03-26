class GamePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
  end
  
  def create?
    user.present?
  end
  
  def update?
    user == record.owner
  end
  
  private
  
  def read?
    user == record.owner || record.published?
  end
end
