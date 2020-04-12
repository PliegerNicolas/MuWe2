class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def my_profile?
    record == user.profile
  end

  def public_profile?
    true
  end
end
