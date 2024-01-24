Rails.application.routes.draw do
  get 'users/new', to: 'users#new', as: 'createacount'
  root 'static_pages#home'
  get '/main', to: 'static_pages#main_view'
  get '/contact', to: 'static_pages#contact'
  get '/signup',  to: 'users#new'

  resources :main
  resources :users
end
