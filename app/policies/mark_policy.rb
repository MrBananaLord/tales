class MarkPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
  end
    
  private
  
  def manage?
    user == record.owner
  end
end
