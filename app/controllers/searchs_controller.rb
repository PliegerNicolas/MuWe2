class SearchsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def index
    @jams = policy_scope(Jam)

    render json: {
      jams: @jams.as_json(include: { user: { only:  [:first_name], methods: :full_name }, music_style: { only: :music_style }, participants: {} } )
    }
  end
end
