Rails.application.routes.draw do
  get 'products/index'
  get 'products/new'
  get 'products/show'
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
  get '/search', to: 'searches#search', as: :search


  resources :farmers, exlude: [:destroy] do
    resources :crates, exclude: [:new]
  end
  # Crates --------------------------
  resources :crates, only: [:index]
  get "/crates", to: "crates#all", as: "all_crates"
  get "my-crates", to: "crates#my_crates", as: "my_crates"
  get "my-crates/new", to: "crates#new_my_crate", as: "new_my_crate"

  # Crate Creation and Update Farmer Only
  # get "my-crates", to: "crates#my_crates", as: "my_crates"
  # get "my-crates/new", to: "crates#new", as: "new_crate"
  # get "my-crates/edit", to: "crates#new", as: "edit_crate"
   get "my-profile", to: "farmers#myprofile", as: "profile"




  resources :events do
    resources :event_attendances, only: [:create, :destroy]
    collection do
      get "category/:category_name", to: "events#by_category", as: "by_category"
    end
  end

  resources :event_attendances do
    collection do
      get "category/:category_name", to: "event_attendances#by_category", as: "by_category"
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"
end

# URLS
# Events/
