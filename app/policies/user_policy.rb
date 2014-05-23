class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
  end
  
  def create?
    !user.present?
  end
  
  def index?
    user.present? && user.admin?
  end
  
  def show?
    true
  end
  
  def manage_roles?
    user.present? && user.admin?  
  end
  
  private
  
  def read?
    user.present?
  end
  
  def manage?
    user.present? && user == record
  end
end
