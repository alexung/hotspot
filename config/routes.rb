	Rails.application.routes.draw do
  get 'welcome/index'

  resources :users, only: [:show]
  resources :repositories, except: [:edit, :update]
  resources :notes


  root "welcome#index"

  get '/search', :to => 'repositories#index'

  get '/code-review', :to => 'repositories#show'

  get '/branch', :to => 'repositories#change_branch'

  # Github Callback
  get '/auth/github/callback', to: 'sessions#create'
  # Logout
  get '/sessions/destroy', to: 'sessions#destroy', as: :logout

end
