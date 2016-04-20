Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root to: "dashboard#index", as: "authenticated_root"
  end

  root to: "welcome#index"

  resources :dashboard, only: [:index]
  resources :vendors
  resources :orders
end
