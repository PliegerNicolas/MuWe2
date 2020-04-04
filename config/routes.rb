Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Error pages

  get '404', to: 'errors#not_found'
  get '422', to: 'errors#unacceptable'
  get '500', to: 'errors#internal_error'
end
