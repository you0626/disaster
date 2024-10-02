Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :friendships
    resources :posts
    resources :disaster_notifications
  end

  resources :shelters
  resources :supplies

  root "users#index"
end