class SearchsController < ApplicationController
  def index
    @jams = policy_scope(Jam)
  end
end
