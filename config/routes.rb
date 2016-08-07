Rails.application.routes.draw do
  resources :pubs do
    resources :events, except: :destroy
    resources :offers
    resources :comments
  end

  resources :users do
    resources :notifications
    resources :subscriptions
    resources :comments, only: :index, controller: :user_comments
  end

  resources :tokens, only: [:create, :destroy]
  resources :beers, except: :destroy
  resources :cities, only: :index
end
