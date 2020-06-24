Rails.application.routes.draw do
  get "/", to: "welcome#index"

  resources :merchants 

  resources :items do
    resources :reviews
  end
 
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"

  resources :reviews

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id/add_quantity", to: "cart#add_quantity"
  patch "/cart/:item_id/decrease-quantity", to: "cart#decrease_quantity"

  resources :orders
  patch "/orders/:id/ship", to: "orders#ship"

  resources :users, only: [:new, :create]

  get "/register", to: "users#new"
  post "/users/new", to: "users#create"

  resources :profile, only: [:index, :edit, :update]
  get "/profile/:id/admin", to: "profile#index"
  get "/password/:user_id/edit", to: "password#edit"
  patch "/password/:user_id", to: "password#update"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  get "profile/orders", to: "profile_orders#index"
  get "profile/orders/:id", to: "profile_orders#show"

  namespace :merchant do
    root "dashboard#index"
    get "/items/new", to: "items#new"
    post "/items", to: "items#create"
    get "/items/:item_id/edit", to: "items#edit"
    patch "/items/:item_id", to: "items#update"
    delete "/items/:item_id", to: "items#destroy"
    get "/items", to: "items#index"

    get "/dashboard", to: "dashboard#index"
    get "/orders/:order_id", to: "orders#show"
    patch "/items/:item_id/orders/:order_id", to: 'orders#update'
  end

  namespace :admin do
    root "dashboard#show"
    get "/profile", to: "profile#index"
    get "/merchants", to: "merchant#index"
    patch "/merchants/:id/update", to: "merchant#update"
    get "/merchants/:merchant_id/items", to: "items#index"
    delete "/merchants/:merchant_id/items/:item_id", to: "items#destroy"
    post "/merchants/:merchant_id/items", to: 'items#create'
    get "/merchants/:merchant_id/items/new", to: "items#new"
    get "/merchants/:merchant_id/items/:item_id/edit", to: 'items#edit'
    patch "/merchants/:merchant_id/items/:item_id", to: "items#update"
    get "/merchants/:id", to: "merchant#show"
    get "/dashboard", to: "dashboard#show"

    get "/users", to: "users#index"
    get "/users/:user_id", to: "users#show"

  end

  resources :logout, only: [:index]
end

