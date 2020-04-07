class JamsController < ApplicationController
  def index
    @jams = policy_scope(Jam)
    authorize @jams
  end

  def new
    @jam = Jam.new
    authorize @jam
  end

  def create
    @jam = Jam.new(jam_params)
    @jam.user = current_user
    authorize @jam
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def jam_params
    params.require(:jam).permit(:user_id, :music_style_id, :description, :max_participations, :status, :start_date_time, :duration, :privacy)
  end
end
