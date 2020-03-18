Rails.application.routes.draw do
  get 'users/show'
  namespace :tweets do
    resources :searches, only: :index
  end
  resources :tweets do
    resources :comments, only: :create
  end
  devise_for :users
  resources :users, only: :show
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
