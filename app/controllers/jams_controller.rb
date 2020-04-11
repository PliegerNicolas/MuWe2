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
    if params[:jam][:address]
      given_address = params[:jam][:address]
      if given_address =~ /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)\s[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/
        coords = given_address.split(/\s/)
        address = Geocoder.search(coords).first
        @address = Address.new(given_address: given_address, street: address.street, postal_code: address.postal_code, city: address.city, country: address.country, latitude: address.latitude, longitude: address.longitude)
      else
        address = Geocoder.search(given_address).first
        return unless address

        @address = Address.new(given_address: given_address, street: address.street, postal_code: address.postal_code, city: address.city, country: address.country, latitude: address.latitude, longitude: address.longitude)
      end
    end
    @jam.address = @address
    authorize @jam
    if @jam.save
      redirect_to jam_path(@jam.id)
    else
      render :new
    end
  end

  def show
    set_jam
  end

  def edit
    set_jam
  end

  def update
    set_jam
    if @jam.update(jam_params)
      redirect_to @jam
    else
      render :edit
    end
  end

  def archive
    set_jam
    @jam.finished!
    if @jam.save
      redirect_to root_path
    else
      redirect_to jam_path(@jam.id)
    end
  end

  def destroy
    set_jam
    @jam.destroy!
    redirect_to root_path
  end

  private

  def jam_params
    params.require(:jam).permit(
      :user_id,
      :music_style_id,
      :description,
      :max_participants,
      :status,
      :start_date_time,
      :privacy,
      :photo,
      :duration
    )
  end

  def set_jam
    @jam = Jam.find(params[:id])
    authorize @jam
  end
end
