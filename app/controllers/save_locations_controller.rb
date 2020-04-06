class SaveLocationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def save_location
    return unless user_signed_in?

    lat = params[:lat]
    lng = params[:lng]
    address = Geocoder.search([lat, lng]).first.address
    @address = Address.new(profile: current_user.profile, address: address, latitude: lat, longitude: lng)
    authorize @address
    if @address.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json
     end
    end
  end
end
