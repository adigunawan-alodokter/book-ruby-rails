Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  get 'books/search', to: 'books#search'
  resources :users
  post '/auth/login', to: 'authentication#login'
  post 'auth/signup', to: 'authentication#signup'
  resources :books
  resources :authors


end
