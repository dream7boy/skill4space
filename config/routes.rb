Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:show, :update] do
    resources :skills, only: [:new, :create]
  end

  resources :spaces, only: [:index, :show, :new, :create]
end
