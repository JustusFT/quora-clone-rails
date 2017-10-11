Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

  resources :questions, only: [:create, :update, :destroy]
  resources :answers, only: [:create, :update, :destroy]
end
