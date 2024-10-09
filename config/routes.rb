Rails.application.routes.draw do
  # typhoon_manual_path へのルート
  get 'typhoon_manual/index', to: 'typhoon_manual#index', as: 'typhoon_manual_index'
  
  # earthquake_manual_path へのルート
  get 'earthquake_manual/index', to: 'earthquake_manual#index', as: 'earthquake_manual_index'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get '/manuals', to: 'manuals#index'

  resources :users do
    resources :friendships
    resources :posts
    resources :disaster_notifications
    post 'update_location', on: :collection
  end

  resources :shelters, except: [:show]

  get 'shelters/download_shelters', to: 'shelters#download_shelters', as: 'download_shelters'

  resources :supplies

  resources :manuals, only: [:index] do
    collection do
      get 'earthquake'
      get 'typhoon'
    end
  end

  post 'shelters/nearby', to: 'shelters#nearby'

  root "users#index"

  get 'search_shelters', to: 'shelters#search'
end