Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:show, :edit, :update] do
    resources :skills, only: [:new, :create]
  end

  get "profile", to: 'users#show'

  resources :spaces, only: [:index, :show, :new, :create]
end
