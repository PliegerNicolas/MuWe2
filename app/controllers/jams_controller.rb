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
    params.require(:jam).permit(:user_id, :music_style_id, :description, :max_participations, :status, :start_date_time, :duration, :privacy)
  end
end
