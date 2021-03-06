Rails.application.routes.draw do

  get 'infomations/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
  resources :users do
    resources :relationships
    resources :account_suspensions
  end

  get "informations" => "infomations#index"

  root "users#timeline"
  get "users/:id/like_notification" => "users#like_notification"
  get "users/:id/reply_notification" => "users#reply_notification"
end
