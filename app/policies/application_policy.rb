class ApplicationPolicy
  attr_reader :user, :record

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end 

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    read?
  end

  def show?
    read?
  end

  def create?
    manage?
  end

  def new?
    create?
  end

  def update?
    manage?
  end

  def edit?
    update?
  end

  def destroy?
    manage?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
  
  private
  
  def read?
    true
  end
  
  def manage?
    false
  end
end
