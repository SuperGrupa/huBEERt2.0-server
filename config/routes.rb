Rails.application.routes.draw do
  resources :pubs do
    resources :events, except: [:show, :destroy]
    resources :offers
    resources :comments, only: [:index, :create]
  end

  resources :users, except: :index do
    resources :notifications, only: [:index, :update]
    resources :subscriptions, except: [:show, :update]
    resources :comments, only: :index, controller: :user_comments
  end

  resources :tokens, only: [:create, :destroy]
  resources :beers, except: [:index, :destroy]
  resources :cities, only: :index
end
