Rails.application.routes.draw do
  root 'welcome#index'


  get "pages/home", to: "pages#home"
  get "pages/produto", to: "pages#produto"
  get "pages/compras", to: "pages#compras"
  get "pages/vendas", to: "pages#vendas"

  devise_for :users

end
