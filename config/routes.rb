Rails.application.routes.draw do
  root 'users#index'
  resources :users, only: [:index, :show] do
    collection do
      get :login
    end
  end
  resources :music, only: [:index]
end
