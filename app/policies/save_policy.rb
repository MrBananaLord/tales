class SavePolicy < ApplicationPolicy
  
  def destroy?
    manage?
  end
  
  private
  
  def manage?
    user.present? && user == record.user
  end
end
