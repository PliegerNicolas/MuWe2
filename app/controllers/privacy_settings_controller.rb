class PrivacySettingsController < ApplicationController
  skip_after_action :verify_authorized
  skip_before_action :authenticate_user!

  def accept_privacy_cookie
    @user_privacy_policy = cookies.permanent[:user_privacy_policy] = "true"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'remove_notice' }
    end
  end

  def close_notice
    @user_privacy_policy = cookies[:user_privacy_policy] = "closed"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'remove_notice' }
    end
  end

  def deny_privacy_cookie
    Address.destroy(current_user.profile.address) if user_signed_in?
    @user_privacy_policy = cookies.permanent[:user_privacy_policy] = "false"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'remove_notice' }
    end
  end

  def reset_privacy_cookie
    # Delete cookie user_privacy_policy a.k.a set it to false
    cookies.delete :user_privacy_policy
    Address.destroy(current_user.profile.address) if user_signed_in?
    @user_privacy_policy = "undefined"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'add_notice' }
    end
  end
end
