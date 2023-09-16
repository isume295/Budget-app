Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :categories do
      resources :exchanges
    end
  end
 
  root "users#index"
 
end
