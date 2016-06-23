Rails.application.routes.draw do
  resources :beers, except: :destroy
  resources :pubs
end
