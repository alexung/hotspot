Rails.application.routes.draw do
  get 'search/index'

  get 'search/show'

  resources :users
  resources :repositories, except: [:edit, :update]
  resources :docs

  root "users#index"
  get '/search', :to => 'repositories#search'
end
