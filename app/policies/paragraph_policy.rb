class ParagraphPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
  end
  
  def set_as_first?
    manage?
  end
  
  private
  
  def manage?
    user == record.game.owner
  end
  
  def read?
    record.game.published? || user == record.game.owner
  end
end
