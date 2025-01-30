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

  resources :farmers, exlude: [:destroy]

  resources :events do
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
