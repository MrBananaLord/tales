class ParagraphPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
  end
  
  def set_as_first?
    manage?
  end
  
  private
  
  def manage?
    user.present? && user == record.game.owner && !record.game.published?
  end
  
  def read?
    record.game.published? || user == record.game.owner
  end
end
