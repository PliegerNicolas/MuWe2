class DashboardsController < ApplicationController
  def dashboard
    @user = current_user
    authorize @user
  end
end
