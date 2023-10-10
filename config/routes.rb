Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  root to: 'login#new'
  get '/login', to: 'login#new', as: :login
  post '/login_web',to: 'login#login_web'



  namespace :api do
    post '/auth/login', to: 'authentication#login_new'
    post 'auth/signup', to: 'authentication#signup'
    resources :authors
    resources :books
    resources :users
  end

end
