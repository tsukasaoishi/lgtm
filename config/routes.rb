Rails.application.routes.draw do
  root 'images#index'

  get "i/:id" => "raw_data#show", as: :raw_datum

  resources :raw_data, only: %i(show)

  resources :images
end
