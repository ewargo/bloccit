Bloccit::Application.routes.draw do

  get "comments/new"

  devise_for :users

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
  end

  match "about" => 'welcome#about', via: :get

  root :to => 'welcome#index'
end