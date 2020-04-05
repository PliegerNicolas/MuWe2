class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permit_location_save?
    record == user.profile
  end

  def deny_location_save?
    record == user.profile
  end
end
