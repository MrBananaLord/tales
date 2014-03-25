class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
  end
  
  def show?
    user.present?
  end
  
  private
  
  def manage?
    user == record
  end
end
