Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :users, controllers: { sessions: 'users/sessions'}

  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
  resources :users do
    resources :relationships
    resources :account_suspensions
  end


  root "users#timeline"
  get "users/:id/like_notification" => "users#like_notification"
  get "users/:id/reply_notification" => "users#reply_notification"
end
