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

    @online_users = Address.near([user_pos[:lat], user_pos[:lng]], 35).where.not(profile_id: nil)
    authorize @online_users
    @online_users = @online_users.to_a.count - 1

    # posts

    @posts = policy_scope(Post)
    byebug

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
