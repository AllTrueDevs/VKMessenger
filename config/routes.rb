Rails.application.routes.draw do
  root 'users#index'

  get '/login', to: 'users#login', as: 'login'
  get '/logout', to: 'users#logout', as: 'logout'
  match '/authorize', to: 'users#authorize', as: 'authorize', via: [:get, :post]
  get '/music', to: 'music#index', as: :music
  get '/user/id:id', to: 'users#change_dialog', as: :change_dialog

  resources :users, only: 'index'
end
