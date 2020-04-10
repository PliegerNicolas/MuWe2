class SearchsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @jams = policy_scope(Jam).includes(:address)
    @markers = []
    @jams.each do |jam|
      if jam.address
        event_coords = {
          lat: jam.address.latitude,
          lng: jam.address.longitude
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
          event_coords: @markers
        }
      end
    end
  end
end
