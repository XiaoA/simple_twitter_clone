Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

#  root to: 'users#index'

  resources :users, only: [:new, :create]
  resources :statuses, only: [:new, :create]
  get "/:username", to: 'users#show', as: 'user'
end
