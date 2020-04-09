class SearchsController < ApplicationController
  def index
    lng = params[:lng]
    lat = params[:lat]
    max_lat = params[:max_lat]
    min_lat = params[:min_lat]
    max_lng = params[:max_lng]
    min_lng = params[:min_lng]
    periode = params[:periode],
    start_date_time = params[:start_date_time],
    duration = params[:duration],
    max_players = params[:max_players],
    status = params[:status]

    byebug

    @jams = policy_scope(Jam).where.not(latitude: nil, longitude: nil)
                             .where('latitude >= :min_lat AND latitude <= :max_lat', min_lat: min_lat, max_lat: max_lat)
                             .where('longitude >= :min_lng AND longitude <= :max_lng', min_lng: min_lng, max_lng: max_lng)
  end
end
