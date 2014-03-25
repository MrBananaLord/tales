class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
  end
  
  def show?
    user.present?
  end
end
