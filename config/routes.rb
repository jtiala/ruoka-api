Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			resources :menu_items, only: [:index, :show]
			resources :menus, only: [:index, :show]
			resources :listings, only: [:index, :show]
			resources :restaurants, only: [:index, :show]
			resources :lists, only: [:index, :show]
		end
	end
end
