class SaveLocationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def save_location
    return unless user_signed_in?

    lat = params[:lat]
    lng = params[:lng]

    if current_user.profile.address
      @address = current_user.profile.address
      authorize @address
      return unless @address.latitude != lat && @address.longitude != lng

      readable_address = Geocoder.search([lat, lng]).first.address
      @address.address = readable_address
      @address.latitude = lat
      @address.longitude = lng
      if @address.save
        respond_to do |format|
          format.html { redirect_to root_path }
          format.json { render :json => {:message => "Success"} }
        end
      end
    else
      readable_address = Geocoder.search([lat, lng]).first.address
      @address = Address.new(profile: current_user.profile, address: readable_address, latitude: lat, longitude: lng)
      authorize @address
      if @address.save
        respond_to do |format|
          format.html { redirect_to root_path }
          format.json { render :json => {:message => "Success"} }
        end
      end
    end
  end
end
