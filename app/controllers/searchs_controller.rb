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

    @jams = policy_scope(Jam).joins(:address).where.not(addresses: { latitude: nil, longitude: nil})
                                             .where('longitude >= ? AND longitude <= ? AND latitude >= ? AND latitude <= ?',
                                             min_bounds[:lng], max_bounds[:lng], min_bounds[:lat], max_bounds[:lat])
                                             .limit(25)
                                             .order('status ASC')
                                             .order('start_date_time ASC')

    # include filters here

    unless filter_params[:periode].blank?
      periode_uniq = Date.today if filter_params[:periode] == 'Today'
      periode_uniq = (Date.today - 1.day) if filter_params[:periode] == 'Yesterday'
      periode_uniq = (Date.today + 1.day) if filter_params[:periode] == 'Tomorrow'
      periode_multiple = [Date.today, Date.today + 7.day] if filter_params[:periode] == "7 days from now"
      periode_multiple = [Date.today, Date.today + 14.day] if filter_params[:periode] == "14 days from now"
      @jams = @jams.filter_by_periode_uniq(periode_uniq) if periode_uniq
      @jams = @jams.filter_by_periode_multiple(periode_multiple) if periode_multiple
    end

    unless filter_params[:start_time].blank? && filter_params[:end_time].blank?
      time_periode = [filter_params[:start_time], filter_params[:end_time]]
      byebug
      # @jams = @jams.filter_by_time(time_periode)
    end

    unless filter_params[:start_time].blank?
    end

    unless filter_params[:end_time].blank?
    end

    set_city(filter_params[:city])

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

  private

  def set_city(given_city)
    unless given_city.blank?
      city = Geocoder.search(given_city)
      @city_coords = [city.first.longitude, city.first.latitude]
    end
  end
end
