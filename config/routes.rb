Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"
  post 'auth/login', to: 'base#authenticate'
  post 'signup', to: 'users#create'

  resources :accounts
  resources :categories
  resources :expense_logs
  resources :internal_transfer_logs, path: 'internal-transfer-logs'

end
