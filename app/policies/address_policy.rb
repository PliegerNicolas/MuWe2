class AddressPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def save_location?
    record.profile.user == user
  end
end
