Rails.application.routes.draw do
  resources :notifications
  resources :subscriptions
  resources :users
  resources :events, except: :destroy
  resources :offers
  resources :comments
  resources :beers, except: :destroy
  resources :pubs
end
