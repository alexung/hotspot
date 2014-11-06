Rails.application.routes.draw do
  resources :users
  resources :repositories
  resources :files

  root "users#index"
end
