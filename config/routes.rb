Rails.application.routes.draw do
  resources :categories, only: %i[show]
  resources :shops do
    collection do
      get :search
    end
    resources :products do
      collection do
        get :search
      end
    end
  end
  devise_for :users
  root 'shops#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
