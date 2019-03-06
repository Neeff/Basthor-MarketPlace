Rails.application.routes.draw do
  get 'products/show'
  get 'products/create'
  get 'products/destroy'
  resources :shops
  devise_for :users
  root 'shops#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
