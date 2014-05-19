class ParentChoicePolicy < ChoicePolicy
  class Scope < ChoicePolicy::Scope
    def resolve
      if user
        scope.joins(:game).where("games.owner_id = ?", user.id)
      else
        []
      end
    end
  end
end
