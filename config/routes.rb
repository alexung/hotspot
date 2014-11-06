Rails.application.routes.draw do
  resources :users
  resources :repositories, except: [:edit, :update]
  resources :docs

  root "users#index"
end
