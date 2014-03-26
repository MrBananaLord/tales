class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
  end
  
  def create?
    !user.present?
  end
  
  private
  
  def read?
    user.present?
  end
  
  def manage?
    user == record
  end
end
