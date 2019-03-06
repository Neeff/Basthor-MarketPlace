Rails.application.routes.draw do
  resources :shops do 
    resources :products, only: %i[new show create destroy]
  end 
  devise_for :users
  root 'shops#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
