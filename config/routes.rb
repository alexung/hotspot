Rails.application.routes.draw do
  resources :users
  resources :repositories
  resources :docs

  root "users#index"
  get '/auth', :to => 'users#auth'
  get '/oauth-callback', :to => 'users#callback'
end
