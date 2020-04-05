class ProfilesController < ApplicationController

  private

  def set_privacy_cookie
    # Set cookie user_privacy_status to string true
    cookies.permanent.signed[:user_privacy_status] = "true"
  end

  def delete_privacy_cookie
    # Delete cookie user_privacy_status a.k.a set it to false
    cookies.delete :user_privacy_status
  end
end
