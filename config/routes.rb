Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'questions#index'

  resources :questions, only: [:create, :update, :destroy, :new, :edit, :index, :show]
  resources :answers, only: [:create, :update, :destroy]
  resources :comments, only: [:create, :update, :destroy]
end
