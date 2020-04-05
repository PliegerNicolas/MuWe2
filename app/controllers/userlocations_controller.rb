class UserlocationsController < ApplicationController
  def permit_location_save
    return unless current_user

    @profile = current_user.profile
    @profile.privacy = true
    authorize @profile
    if @profile.save
      respond_to do |format|
        format.html { redirect_to root_path } # Should become profile_path
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path } # Should become profile_path
        format.js
      end
    end
  end

  def deny_location_save
    return unless current_user

    @profile = current_user.profile
    @profile.privacy = false
    authorize @profile
    if @profile.save
      respond_to do |format|
        format.html { redirect_to root_path } # Should become profile_path
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path } # Should become profile_path
        format.js
      end
    end
  end
end
