Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'questions#index'

  resources :questions, only: [:create, :update, :destroy, :new, :edit, :index, :show] do
    resources :answers, only: [:create]
  end

  resources :answers, only: [:update, :destroy] do
    resources :comments, only: [:create]
  end

  resources :comments, only: [:update, :destroy] do
    resources :comments, only: [:create]
  end
end
