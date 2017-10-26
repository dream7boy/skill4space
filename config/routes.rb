Rails.application.routes.draw do
  devise_for :users
  mount Attachinary::Engine => "/attachinary"
  root to: 'pages#home'
  resources :users, only: [:show, :edit, :update] do
    resources :skills, only: [:new, :create, :destroy]
    resources :user_reviews, only: [:new, :create]
  end

  get "profile", to: 'users#profile'
  get "bookings", to: 'users#bookings'
  get "listings", to: 'users#listings'

  resources :spaces, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:destroy]
end
