Rails.application.routes.draw do
  devise_for :users
  root to: 'jams#index'

  # Jams routes

  get 'jam/:id', to: 'jams#archive', as: :archive_jam
  resources :jams

  # Dashboard routes

  get 'dashboard', to: 'dashboards#dashboard'

  # Profile routes

  get 'my_profile', to: 'profiles#my_profile', as: :my_profile
  get 'profile/:id', to: 'profiles#public_profile', as: :profile

  # User privacy settings

  get 'close_notice', to: 'privacy_settings#close_notice', as: :close_privacy_cookie_notice
  get 'accept_privacy_cookie', to: 'privacy_settings#accept_privacy_cookie', as: :accept_privacy_cookie
  get 'deny_privacy_cookie', to: 'privacy_settings#deny_privacy_cookie', as: :deny_privacy_cookie
  get 'reset_privacy_cookie', to: 'privacy_settings#reset_privacy_cookie', as: :reset_privacy_cookie

  # User data

  post 'local_data', to: 'local_datas#local_data'

  # Search for events => Map

  post 'search', to: 'searchs#index'

  # Save user position

  post 'save_location', to: 'save_locations#save_location', as: :save_location

  # Error pages

  get '404', to: 'errors#not_found'
  get '422', to: 'errors#unacceptable'
  get '500', to: 'errors#internal_error'
end
