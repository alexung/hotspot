Rails.application.routes.draw do
  resources :users
  resources :repositories, except: [:edit, :update]
  resources :docs

  root "users#index"

  # Github Callback
  get '/auth/github/callback', to: 'sessions#create'
  # Logout
  get '/sessions/destroy', to: 'sessions#destroy', as: :logout

end
