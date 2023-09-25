Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  get 'books/search', to: 'books#search'
  resources :users
  post '/auth/login', to: 'authentication#login'
  resources :books
  resources :authors


end
