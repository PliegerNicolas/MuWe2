class ProfilesController < ApplicationController
  def my_profile
    @profile = current_user.profile
    authorize @profile
  end

  def public_profile
    @profile = Profile.find(params[:id])
    authorize @profile
    if @profile = current_user.profile
      redirect_to my_profile_path
    end
  end
end
