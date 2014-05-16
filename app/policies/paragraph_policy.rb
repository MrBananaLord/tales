class ParagraphPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
  end
  
  def set_as_first?
    manage?
  end
  
  private
  
  def manage?
    user == record.game.owner && !record.game.published?
  end
  
  def read?
    user == record.game.owner || record.game.published?
  end
end
