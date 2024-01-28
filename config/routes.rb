Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new', to: 'users#new', as: 'createacount'
  root 'static_pages#home'
  get '/main', to: 'static_pages#main_view'
  get '/contact', to: 'static_pages#contact'
  get '/signup',  to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :main
  resources :users
end
