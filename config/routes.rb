Rails.application.routes.draw do
  get "welcome/index"
  root :to => 'welcome#index'
  resources :users, only: %i(index)
  namespace :api do
    resources :users
    post "users/exists", as: "users_exists", to: "users#exists"
  end
end
