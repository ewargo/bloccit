Bloccit::Application.routes.draw do

  get "comments/new"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy, :show]
    end
  end

  match "about" => 'welcome#about', via: :get

  root :to => 'welcome#index'
end