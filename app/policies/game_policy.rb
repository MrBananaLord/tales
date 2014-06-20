class GamePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope      
    def resolve
      if user
        scope.where("owner_id = ? OR published_at < ?", user.id, Time.now)
      else
        scope.published
      end
    end
  end
  
  def new?
    user.present?
  end
  
  def play?
    record.first_paragraph.present? &&
    (record.published? || manage?)
  end
  
  def publish?
    manage? && !record.published?
  end
  
  def unpublish?
    user.present? && (user.admin? || user == record.owner) && record.published?
  end
    
  def mark?
    user.present? && record.published?
  end
  
  def save?
    user.present? && record.published?
  end
  
  def control?
    user.present? && (user.admin? || user == record.owner)
  end
  
  private
  
  def manage?
    user.present? && !record.published? && (user.admin? || user == record.owner)
  end
  
  def read?
    record.published? || manage?
  end
end
