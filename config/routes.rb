Rails.application.routes.draw do
  resources :users
  resources :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"




  get '/login', to: 'sessions#index'
  post '/login', to: 'sessions#create'
  get '/login/:id', to: 'sessions#show'
  post '/user_login', to: "sessions#create_user"


  delete '/logout', to: "sessions#destroy"

  post '/admin/create', to: 'admins#create'

  # admin
  post 'admin/login', to: 'admin#login'
  post '/login', to: 'admin#login'
  post '/signup', to: 'admin#signup'
  post "/adminin", to: "sessions#in"
  delete "/adminout", to: "sessions#out"
  get "/ad", to: "admins#show"
  post "/newadmin", to: "admins#create"


  # USERs routes
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  post "/users", to: "users#create"
  patch "/users/:id", to: "users#update"
  delete "/users/:id", to: "users#destroy"

end
