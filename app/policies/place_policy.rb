class PlacePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true  # Anyone can view a place
  end

  def create?
    true  # Anyone can create a place
  end

  def update?
    record.user == user  # Only place creator can update it
  end

  def destroy?
    record.user == user  # Only place creator can update it
  end

  def home?
    true
  end
end
