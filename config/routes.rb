Rails.application.routes.draw do
  resources :tweets do
    resources :comments, only: :create
  end
  devise_for :users
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
