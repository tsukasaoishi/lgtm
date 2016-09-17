Rails.application.routes.draw do
  root 'images#index'

  scope protocol: 'https://', constrains: {protocol: 'https'} do
    get "i/:id" => "raw_data#show", as: :raw_datum
  end

  resources :raw_data, only: %i(show)

  resources :images
end
