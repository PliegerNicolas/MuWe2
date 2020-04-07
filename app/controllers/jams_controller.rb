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
    set_duration(params[:jam]["duration(4i)"], params[:jam]["duration(5i)"])
    authorize @jam
    if @jam.save
      redirect_to jam_path(@jam.id)
    else
      render :new
    end
  end

  def show
    @jam = Jam.find(params[:id])
    authorize @jam
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def jam_params
    params.require(:jam).permit(:user_id, :music_style_id, :description, :max_participants, :status, :start_date_time, :duration, :privacy, :photo)
  end

  def set_duration(hour, seconds)
    duration = Time.parse("#{hour}:#{seconds}").seconds_since_midnight.to_i
    @jam.duration = duration
  end
end
