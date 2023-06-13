Rails.application.routes.draw do
  resources :reservations
  resources :bookings
  resources :amenities
  resources :airbnb_images
  resources :airbnbs
  resources :users
  resources :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get "/login", to: "sessions#index"
  # post "/adminlogin", to: "sessions#create"
  # get "/login/:id", to: "sessions#show"
  # post "/user_login", to: "sessions#create_user"
  # delete "/logout", to: "sessions#destroy"
  # post "/admin/create", to: "admins#create"

  # admin login route
  post "/admin/login", to: "adminsessions#create"
  delete "/admin/logout", to: "adminsessions#destroy"

  # user login route
  post "/user/login", to: "sessions#create"
  delete "/user/logout", to: "sessions#destroy"
  post "/user/signup", to: "users#create"

  # admin
  post "admin/login", to: "admin#login"
  post "/login", to: "admin#login"
  post "/signup", to: "admin#signup"
  post "/adminin", to: "sessions#in"
  delete "/adminout", to: "sessions#out"
  get "/ad", to: "admins#show"
  post "/newadmin", to: "admins#create"
  patch "/admins", to: "admins#update"

  # USERs routes
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  post "/users", to: "users#create"
  patch "/users/:id", to: "users#update"
  delete "/users/:id", to: "users#destroy"

  # AIRBNB routes
  get "/airbnbs", to: "airbnbs#index"
  get "/airbnbs/:id", to: "airbnbs#show"
  post "/airbnbs", to: "airbnbs#create"
  patch "/airbnbs/:id", to: "airbnbs#update"
  delete "/airbnbs/:id", to: "airbnbs#destroy"

  # AIRBNB IMAGES routes
  get "/airbnb_images", to: "airbnb_images#index"
  get "/airbnb_images/:id", to: "airbnb_images#show"
  post "/airbnb_images", to: "airbnb_images#create"
  patch "/airbnb_images/:id", to: "airbnb_images#update"
  delete "/airbnb_images/:id", to: "airbnb_images#destroy"

  # AMENITIES routes
  get "/amenities", to: "amenities#index"
  get "/amenities/:id", to: "amenities#show"
  post "/amenities", to: "amenities#create"
  patch "/amenities/:id", to: "amenities#update"
  delete "/amenities/:id", to: "amenities#destroy"

  # BOOKINGS routes
  get "/bookings", to: "bookings#index"
  get "/bookings/:id", to: "bookings#show"
  post "/bookings", to: "bookings#create"
  patch "/bookings/:id", to: "bookings#update"
  delete "/bookings/:id", to: "bookings#destroy"


  # RESERVATIONS routes
  get "/reservations", to: "reservations#index"
  get "/reservations/:id", to: "reservations#show"
  post "/reservations", to: "reservations#create"
  patch "/reservations/:id", to: "reservations#update"
  delete "/reservations/:id", to: "reservations#destroy"
  
end
