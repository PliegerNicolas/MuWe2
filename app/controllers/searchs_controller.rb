class SearchsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @jams = policy_scope(Jam)

    respond_to do |format|
      format.json do |f|
        render json: {
          jams: render_to_string(
            partial: 'jams/jam',
            formats: :html,
            layout: false,
            locals: { jams: @jams }
          )
        }
      end
    end
  end
end
