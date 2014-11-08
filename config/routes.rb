Rails.application.routes.draw do
  resources :users
  resources :repositories, except: [:edit, :update]
  resources :commits, only: [:show, :index]
  
  resources :docs

  root "users#index"

  get '/search', :to => 'repositories#index'

  get '/code_review', :to => 'repositories#show'

  # Github Callback
  get '/auth/github/callback', to: 'sessions#create'
  # Logout
  get '/sessions/destroy', to: 'sessions#destroy', as: :logout

end
