Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  get '/login', to: 'users#login', as: 'login'
  get '/logout', to: 'users#logout', as: 'logout'
  match '/authorize', to: 'users#authorize', as: 'authorize', via: [:get, :post]
  get '/music', to: 'music#index', as: :music
  get '/user/id:id', to: 'messages#change_dialog', as: :change_dialog
  post '/send', to: 'messages#sending', as: :sending
  resources :users, only: 'index'
end
