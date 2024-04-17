Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :jid_pools, only: [:index] do
    post :populate, on: :collection
  end

  resources :users, only: [:index] do
    post :populate, on: :collection
  end

  root to: 'jid_pools#index'
end