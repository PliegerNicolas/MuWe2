class SearchsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @jams = policy_scope(Jam).includes(:address)
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

    respond_to do |format|
      format.json do |f|
        render json: {
          jams: render_to_string(
            partial: 'jams/jam',
            formats: :html,
            layout: false,
            locals: { jams: @jams }
          ),
          jam_coords: @markers
        }
      end
    end
  end
end
