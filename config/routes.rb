Rails.application.routes.draw do
  devise_for :users
  root to: 'jams#index'

  # Permissions for saving User location

  get 'location', to: 'userlocations#permit_location_save', as: :permit_location_save
  get 'location', to: 'userlocations#deny_location_save', as: :deny_location_save

  # Error pages

  get '404', to: 'errors#not_found'
  get '422', to: 'errors#unacceptable'
  get '500', to: 'errors#internal_error'
end
