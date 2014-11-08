	Rails.application.routes.draw do
  resources :users, only: [:show, :index]
  resources :repositories, except: [:edit, :update]

  root "users#index"

  get '/search', :to => 'repositories#index'

  get '/code-review', :to => 'repositories#show'


  # Github Callback
  get '/auth/github/callback', to: 'sessions#create'
  # Logout
  get '/sessions/destroy', to: 'sessions#destroy', as: :logout

end
