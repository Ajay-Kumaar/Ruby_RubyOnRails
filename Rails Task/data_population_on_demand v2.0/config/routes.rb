Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :jid_pools do
    post :threshold, on: :collection
    post :populate, on: :collection
  end

  resources :users do
    post :manual_user_addition, on: :collection
    post :bulk_user_addition, on: :collection
    post :show_users, on: :collection
    post :process_manual_user_addition, on: :collection
  end

  root to: 'jid_pools#index'
end