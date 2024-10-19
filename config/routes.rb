Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :warehouses do
    resources :stock_product_destinations, only: %i[create]
  end

  resources :suppliers
  resources :product_models

  resources :orders do
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member

    resources :order_items, only: %i[new create]
  end
end
