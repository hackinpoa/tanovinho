Rails.application.routes.draw do
  root 'welcome#index'


  get "pages/home", to: "pages#home"
  get "pages/produto", to: "pages#produto"

  devise_for :users

end
