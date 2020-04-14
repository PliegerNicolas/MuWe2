class LocalDatasController < ApplicationController
  skip_before_action :authenticate_user!

  def local_data
    return unless cookies[:user_privacy_policy] == "true"

    user_pos = params[:local_data][:user_pos]

    # Online Users and City

    found_user_city = Geocoder.search([user_pos[:lat], user_pos[:lng]]).first
    if found_user_city
      @city = found_user_city.city
    else
      @city = "..."
    end

    near_addresses = Address.near([user_pos[:lat], user_pos[:lng]], 35).where.not(profile_id: nil)
    @online_users = near_addresses
    authorize @online_users
    @online_users = @online_users.to_a.count
    @online_users -= 1 if current_user

    # posts

    @posts = near_addresses.map { |address| address.profile.posts.last }.flatten

    respond_to do |format|
      format.json do |f|
        render json: {
          posts: render_to_string(
            partial: 'posts/post',
            formats: :html,
            layout: false,
            locals: { posts: @posts }
          ),
          city: @city,
          online_users: @online_users
        }
      end
    end
  end
end
