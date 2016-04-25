Rails.application.routes.draw do
  resources :activities
  resources :activities
  devise_for :users
  authenticated :user do
    root to: "dashboard#index", as: "authenticated_root"
  end

  root to: "welcome#index"

  resources :dashboard, only: [:index]
  resources :vendors
  resources :users, only: [:index, :destroy] do
    member do
      patch :admin
    end
  end
  resources :orders do
    collection do
      get 'search'
    end
    member do
      patch :complete
    end
    resources :items, only: [:create]
  end
  resources :items, only: [:edit, :update, :destroy]
end
