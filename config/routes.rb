Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
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
    get "check_availability", to: 'spaces#check_availability'
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:destroy]

  resources :conversations do
    resources :messages
  end
end
