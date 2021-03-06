Rails.application.routes.draw do
  notify_to :users
  root "books#index"

  post '/rate' => 'rater#create', :as => 'rate'
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get "/auth/:provider/callback", :to => "sessions#create"
  get "/auth/failure", :to => "session#new"
  get "/books/filter", to: 'books#filter'
  get "/books/delete", to: "books#index"

  resources :reviews do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [ :create, :destroy ]
  end
  resources :users
  resources :books do
    resources :bookmarks, only: [:create, :destroy]
  end
  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index show destroy)
  resources :categories
  resources :relationships, only: [:create, :destroy]
end
