Rails.application.routes.draw do
  resources :categories, only: %i[show]
  resources :orders, only:%i[destroy] do
    collection do
        get :cart
    end
    
  end
  resources :shops do
    collection do
      get :search
      get :cart
    end
    resources :products do
      collection do
        get :search
      end
      resources :orders, only: %i[create]
    end
  end
  devise_for :users
  root 'shops#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
