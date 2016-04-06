Rails.application.routes.draw do
  root 'images#index'

  resources :raw_data, only: %i(show)

  resources :images
end
