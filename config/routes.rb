Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :warehouses
  resources :suppliers
  resources :product_models

  resources :orders do
    get 'search', on: :collection
  end
end
