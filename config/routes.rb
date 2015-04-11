Rails.application.routes.draw do
  root 'welcome#index'

  get "pages/home", to: "pages#home"
end
