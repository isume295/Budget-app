Rails.application.routes.draw do
  devise_for :users
  resources :exchanges
  resources :categories
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
  get 'users/:id/category', to: 'categories#index', as: 'user_category'
  get '/categories/:id/exchanges', to: 'exchanges#index', as: 'category_exchanges'
end
