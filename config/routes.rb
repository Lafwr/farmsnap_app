Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  get 'events/index'
  get 'events/show'
  get 'events/edit'
  get 'events/update'
  get 'events/new'
  get 'events/create'
  get 'events/destroy'


  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :farmers, exlude: [:destroy] do
    resources :crates
  end
  # Crates ---------------------------
  get "/crates", to: "crates#all", as: "all_crates"

  resources :crates do
    collection do
      get "seafood", to: "crates#seafood", as: "seafood"
      get "dairy", to: "crates#dairy", as: "dairy"
      get "meat", to: "crates#meat", as: "meat"
      get "organic", to: "crates#organic", as: "organic"
      get "halal", to: "crates#halal", as: "halal"
      get "fruit-and-veg", to: "crates#fruitandveg", as: "fruit_and_veg"
      get "baked-goods", to: "crates#baked_goods", as: "baked_goods"
      get "alcohol", to: "crates#alcohol", as: "alcohol"
    end
  end


  # Crate Creation and Update Farmer Only
  # get "my-crates", to: "crates#my_crates", as: "my_crates"
  # get "my-crates/new", to: "crates#new", as: "new_crate"
  # get "my-crates/edit", to: "crates#new", as: "edit_crate"


  resources :events do
    resources :event_attendances, only: [:create, :destroy]
    collection do
      get "seafood", to: "events#seafood", as: "seafood"
      get "dairy", to: "events#dairy", as: "dairy"
      get "meat", to: "events#meat", as: "meat"
      get "organic", to: "events#organic", as: "organic"
      get "halal", to: "events#halal", as: "halal"
      get "fruit-and-veg", to: "events#fruitandveg", as: "fruit_and_veg"
      get "baked-goods", to: "events#baked_goods", as: "baked_goods"
      get "alcohol", to: "events#alcohol", as: "alcohol"
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"
end

# URLS
# Events/
