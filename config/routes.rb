Rails.application.routes.draw do

  root 'products#index'

  devise_for :users

  resources :purchases, only: [:index, :show] do
    post 'abandoned', on: :collection
    post 'notification', on: :collection
  end

  resources :products do
    resources :purchases, only: [:new, :create]
  end
end
