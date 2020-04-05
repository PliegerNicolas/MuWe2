class UserlocationsController < ApplicationController
  def permit_location_save
    return unless current_user

    @profile = current_user.profile
    @profile.privacy = true
    authorize @profile
    @profile.save

    redirect_to root_path # Should become AJAX
  end

  def deny_location_save
    return unless current_user

    @profile = current_user.profile
    @profile.privacy = false
    authorize @profile
    @profile.save

    redirect_to root_path # Should become AJAX
  end
end
