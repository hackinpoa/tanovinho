Rails.application.routes.draw do
  root 'welcome#index'


  get "pages/home", to: "pages#home"

  devise_for :users

end
