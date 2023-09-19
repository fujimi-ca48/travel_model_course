Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
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
  get 'privacy_policy', to: 'top_pages#privacy_policy'
  get 'terms_of_service', to: 'top_pages#terms_of_service'
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
  resources :model_courses, only: %i[new create show index edit update destroy]
  resources :recommended_spots, only: %i[index new create destroy show edit update]
  resources :total_spot_items, only: %i[index new create update destroy] do
    member do
      patch :sort
    end

    collection do
      get :get_total_spot_items_count
    end
  end
  resource :profile, onley: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
