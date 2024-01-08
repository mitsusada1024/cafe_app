Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  get '/main', to: 'static_pages#main_view'
  get '/contact', to: 'static_pages#contact'
end
