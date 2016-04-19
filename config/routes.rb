Rails.application.routes.draw do
  devise_for :users
  root to: "orders#index"

  resources :vendors
  resources :orders
end
