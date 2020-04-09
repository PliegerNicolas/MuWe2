class SaveLocationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def save_location
    unless user_signed_in?
      skip_authorization
      return
    end

    lat = params[:lat].round(7)
    lng = params[:lng].round(7)

    if current_user.profile.address
      @address = current_user.profile.address
      authorize @address
      return if @address.latitude == lat && @address.longitude == lng

      found_address = Geocoder.search([lat, lng]).first
      @address.given_address = found_address.address
      @address.country = found_address.country
      @address.city = found_address.city
      @address.postal_code = found_address.postal_code
      @address.street = found_address.street
      @address.latitude = lat
      @address.longitude = lng
      if @address.save
        respond_to do |format|
          format.html { redirect_to root_path }
          format.json { render :json => {:message => "Success"} }
        end
      end
    end
  end
end
