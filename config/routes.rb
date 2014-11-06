Rails.application.routes.draw do
  resources :users
  resources :repositories
  resources :docs

  root "users#index"
end
