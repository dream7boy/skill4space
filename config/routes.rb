Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [ :show, :update ]
  resources :spaces, only: [:index, :show, :new, :create]
end
