class ChildrenChoicePolicy < ChoicePolicy
  class Scope < ChoicePolicy::Scope
    def resolve
      if user
        scope.joins(:game).
        where("child_paragraph_id IS NOT NULL OR games.owner_id = ?", user.id)
      else
        scope.where("child_paragraph_id IS NOT NULL")
      end
    end
  end
end
