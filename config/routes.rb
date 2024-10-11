Rails.application.routes.draw do
  root "home#index"
  resources :warehouses
  resources :suppliers
end
