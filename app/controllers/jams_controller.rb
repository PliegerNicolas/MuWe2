class JamsController < ApplicationController
  def index
    @jams = policy_scope(Jam)
    authorize @jams
  end
end
