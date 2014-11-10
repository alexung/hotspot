	Rails.application.routes.draw do
  get 'welcome/index'

  resources :users, only: [:show]
  resources :repositories, except: [:update]
  resources :notes


  root "welcome#index"

  get '/search', :to => 'searches#index'

  get '/code-review', :to => 'code_reviews#new_code_review'

  get '/branch', :to => 'repositories#change_branch'

  # Github Callback
  get '/auth/github/callback', to: 'sessions#create'
  # Logout
  get '/sessions/destroy', to: 'sessions#destroy', as: :logout

end
