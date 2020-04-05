class PrivacySettingsController < ApplicationController
  skip_after_action :verify_authorized
  skip_before_action :authenticate_user!

  def accept_privacy_cookie
    @user_privacy_policy = cookies.permanent.signed[:user_privacy_policy] = "true"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def close_notice
    @user_privacy_policy = cookies.signed[:user_privacy_policy] = "closed"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def deny_privacy_cookie
    @user_privacy_policy = cookies.permanent.signed[:user_privacy_policy] = "false"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def reset_privacy_cookie
    # Delete cookie user_privacy_policy a.k.a set it to false
    cookies.delete :user_privacy_policy
    @user_privacy_policy = "undefined"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
