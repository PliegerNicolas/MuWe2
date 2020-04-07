class JamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    record.user == user
  end

  def update?
    record.user == user
  end

  def archive?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
