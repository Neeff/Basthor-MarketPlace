Rails.application.routes.draw do
  resources :categories, only: %i[show]
  resources :orders, only: %i[index destroy] do
    collection do
      get :cart
      delete :empty_cart
    end
    member do
        patch :add_item
        patch :less_item
        patch :dispached
    end

  end
  resources :shops do
    collection do
      get :search
      get :cart
      get :dashboard
    end
    resources :products do
      collection do
        get :search
      end
      resources :orders, only: %i[create]
    end
  end
  resources :billings, only: [] do
    collection do
      post 'pre_pay'
      get 'execute'
    end
  end
  devise_for :users
  root 'shops#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
