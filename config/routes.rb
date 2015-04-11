Rails.application.routes.draw do
  resources :products

  root 'welcome#index'

  devise_for :users
end
