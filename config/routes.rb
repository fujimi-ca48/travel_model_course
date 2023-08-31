Rails.application.routes.draw do
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :tourist_spots
    resources :users, only: %i[new create]
  end

  get 'google_login_api/callback'
  root 'top_pages#top'
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post '/google_login_api/callback', to: 'google_login_api#callback'

  resources :tourist_spots, only: %i[index show] do
    collection do
      get :search
    end
  end
  resources :model_courses, only: %i[new create show index]
  resources :recommended_spots, only: %i[index new create destroy]
  resources :total_spot_items, only: %i[index new create update destroy] do
    member do
      patch :sort
    end
  end
end
