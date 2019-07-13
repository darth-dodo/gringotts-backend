Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"
  post 'auth/login', to: 'base#authenticate'
  post 'signup', to: 'users#create'

  resources :accounts do
    member do
      post :toggle_favorite, path: "toggle-favorite"
    end
  end

  resources :categories do
    member do
      post :toggle_favorite, path: "toggle-favorite"
    end
  end

  resources :expense_logs do
    member do
      post :toggle_favorite, path: "toggle-favorite"
    end
  end

  resources :internal_transfer_logs, path: 'internal-transfer-logs'

end
