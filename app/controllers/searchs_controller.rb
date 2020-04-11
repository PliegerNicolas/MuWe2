class SearchsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # Set params

    map_center = params[:map_center]
    max_bounds = {
      lat: params[:max_lat],
      lng: params[:max_lng]
    }
    min_bounds = {
      lat: params[:min_lat],
      lng: params[:min_lng]
    }
    filter_params = params[:filter]
    # End set params

    @jams = policy_scope(Jam).includes(:address)

    unless filter_params[:city].blank?
      city = Geocoder.search(filter_params[:city])
      @city_coords = [city.first.longitude, city.first.latitude]
    end

    # Set markers

    @markers = []
    @jams.each do |jam|
      if jam.address
        marker_image = helpers.asset_url('muwe-pin-ongoing.svg') if jam.status == 'ongoing'
        marker_image = helpers.asset_url('muwe-pin-planned.svg') if jam.status == 'planned'
        marker_image = helpers.asset_url('muwe-pin-finished.svg') if jam.status == 'finished'

        event_coords = {
          lat: jam.address.latitude,
          lng: jam.address.longitude,
          marker_image: marker_image
        }
        @markers << event_coords
      end
    end

    # End set markers

    respond_to do |format|
      format.json do |f|
        render json: {
          jams: render_to_string(
            partial: 'jams/jam',
            formats: :html,
            layout: false,
            locals: { jams: @jams }
          ),
          jam_coords: @markers,
          city_coords: @city_coords
        }
      end
    end
  end
end
