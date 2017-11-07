Rails.application.routes.draw do

  resources :reviews
  get 'users/show'

  get 'sessions/new'

  get 'users/new'
  root "books#index"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'


  get "/auth/:provider/callback", :to => "sessions#create"
  get "/auth/failure", :to => "session#new"

  resources :users
  resources :books
  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index show destroy)
  resources :categories
end
