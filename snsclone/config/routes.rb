Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
  resources :users do
  	resources :relationships
  end
  get "users/:id/timeline" => "users#timeline"
  root "tweets#index"
  
end
