Rails.application.routes.draw do
  resources :pubs do
    resources :events, except: :destroy
    resources :offers
    resources :comments
  end

  resources :users do
    resources :tokens, only: [:create, :destroy]
    resources :notifications
    resources :subscriptions
  end

  resources :beers, except: :destroy
end
