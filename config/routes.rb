Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users do
    resources :friendships
    resources :posts
    resources :disaster_notifications
    post 'update_location', on: :collection
  end

  resources :shelters do
    collection do
      get :download # ここをpostからgetに変更
    end
  end

  resources :supplies

  root "users#index"
end