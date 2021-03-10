Rails.application.routes.draw do
  get 'search/search'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root :to => "homes#top"
  get "home/about" => "homes#about"

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update]
  resources :users, only: [:index, :show, :edit, :update]
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  get '/search', to: 'search#search'
end
