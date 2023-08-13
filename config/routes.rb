Rails.application.routes.draw do
  root 'top_pages#top'
  resources :users, only: [:new, :create]
end
