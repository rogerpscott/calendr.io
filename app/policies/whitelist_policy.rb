class WhitelistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(place: @place)
    end
  end

  def create?
    record.place.user == user  # Only place creator can update it
  end

  def new?
    record.place.user == user  # Only place creator can update it
  end

  def destroy?
    record.place.user == user   # Only place creator can update it
  end
end
