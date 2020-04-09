class SearchsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def index
    byebug
    @jams = policy_scope(Jam)
  end
end
