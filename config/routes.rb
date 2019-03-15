Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'locations/find_address'
  resources :categories, only: %i[show]
  resources :orders, only: %i[index destroy] do
    collection do
      get :cart
      get :user
      get :dashboard
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
    end
    resources :products do
      collection do
        get :search
        get :search_range_price
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
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get 'locations/find_address'
  root 'shops#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
