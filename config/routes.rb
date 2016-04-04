Rails.application.routes.draw do
  root 'users#index'

  get '/login', to: 'users#login', as: 'login'
  get '/logout', to: 'users#logout', as: 'logout'
  match '/authorize', to: 'users#authorize', as: 'authorize', via: [:get, :post]
  get '/music', to: 'music#index', as: :music

  resources :users, only: [:show, :index]
end
