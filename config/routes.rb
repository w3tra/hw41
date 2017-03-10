Rails.application.routes.draw do
  get '/feed', to: 'posts#feed'
  root 'posts#feed'
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
  	member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :posts do
   resources :comments
   member do
      get :like, :unlike
    end
  end
end
