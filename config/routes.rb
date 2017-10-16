Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  resources :products do
    member do
      put 'like', to: 'products#upvote'
      put 'dislike', to: 'products#downvote'
    end
  end
  resources :categories
  resources :users, only: [:index, :show]
  root 'pages#index'

  get 'my_products', to: 'products#my_products'
  # get 'search_products', to: 'products#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
