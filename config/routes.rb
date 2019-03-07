Rails.application.routes.draw do
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
