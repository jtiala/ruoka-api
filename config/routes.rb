Rails.application.routes.draw do
  resources :menu_items
  resources :menus
  resources :listings
  resources :restaurants
  resources :lists
end
