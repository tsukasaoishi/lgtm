Rails.application.routes.draw do
  root 'images#index'

  get 'i/:id' => "images#cached_image", as: :cache_image

  resources :images
end
