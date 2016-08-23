class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true  # Anyone can view a booking
  end

  def create?
    true  # Anyone can create a booking
  end

  def update?
    record.user == user  # Only booking creator can update it
  end

  def destroy?
    record.user == user  # Only booking creator can update it
  end
end
