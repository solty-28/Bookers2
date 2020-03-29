Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'books#welcome'
  get '/home/about' => 'books#about', as: 'about'
  get '/users' => 'users#users', as: 'users'
  get '/books' => 'books#index', as: 'index'

  resources :books, only: [:create, :show, :destroy, :update, :edit]

  resources :users, only: [:show, :edit, :update]

end
