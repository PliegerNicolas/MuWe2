class PrivacySettingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def set_privacy_cookie?
    true
  end

  def privacy_cookie_to_false?
    true
  end

  def delete_privacy_cookie?
    true
  end
end
