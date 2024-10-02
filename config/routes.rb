Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :friendships
    resources :posts
    resources :disaster_notifications
    resources :shelters
    resources :supplies
  end

  root "users#index"
end