Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:show, :edit, :update] do
    resources :skills, only: [:new, :create, :destroy]
  end

  get "profile", to: 'users#profile'
  get "bookings", to: 'users#bookings'
  get "listings", to: 'users#listings'

  resources :spaces, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
