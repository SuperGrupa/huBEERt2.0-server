Rails.application.routes.draw do
  resources :pubs do
    resources :events, except: :destroy
    resources :offers
    resources :comments
  end

  resources :users do
    resources :notifications
    resources :subscriptions
  end

  resources :tokens, only: [:create, :destroy]
  resources :beers, except: :destroy
  resources :cities, only: :index
end
