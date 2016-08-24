class WhitelistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    record.place.user == user  # Only place creator can update it
  end

  def destroy?
    record.place.user == user   # Only place creator can update it
  end
end
