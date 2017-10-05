Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  resources :products
  resources :categories
  resources :users, only: [:index, :show]
  root 'pages#index'

  get 'my_products', to: 'products#my_products'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
