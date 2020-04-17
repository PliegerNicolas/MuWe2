class LocalDatasController < ApplicationController
  skip_before_action :authenticate_user!

  def local_data
    unless cookies[:user_privacy_policy] == "true"
      skip_authorization
      return
    end

    user_pos = params[:local_data][:user_pos]

    # Online Users and City

    found_user_city = Geocoder.search([user_pos[:lat], user_pos[:lng]]).first
    if found_user_city
      @city = found_user_city.city
    else
      @city = "..."
    end

    near_addresses = Address.near([user_pos[:lat], user_pos[:lng]], 35).where.not(profile_id: nil)
    @online_users = near_addresses.joins(:profile).where("profiles.last_activity >= ?", DateTime.now.utc - 5.minutes)
    authorize @online_users
    @online_users = @online_users.to_a.count
    @online_users -= 1 if current_user

    # local posts

    @local_posts = near_addresses.map { |address| address.profile.posts.last }.flatten.compact!

    local_posts_html = []
    Array(@local_posts).each do |post|
      local_posts_html << render_to_string(partial: 'posts/post', formats: :html, layout: false, locals: { post: post })
    end

    respond_to do |format|
      format.json do |f|
        render json: {
          local_posts: local_posts_html,
          city: @city,
          online_users: @online_users
        }
      end
    end
  end
end
