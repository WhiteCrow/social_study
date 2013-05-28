SocialStudy::Application.routes.draw do

  resources :comments, only: [:create, :destroy]

  resources :notes do
    member do
      post :reputed
    end
  end

  resources :experiences do
    member do
      post :reputed
    end
  end

  resources :microblogs

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users, :path => "account", :controllers => {
    :registrations => :account,
    :sessions => :sessions,
    :omniauth_callbacks => "users/omniauth_callbacks"
    } do
    get "account/update_private_token" => "account#update_private_token", :as => :update_private_token_account
  end

  resources :comments
  resources :users, :only => [:show] do
    member do
      get :follow
      get :unfollow
      get :following
      get :followers
      get :repute
      get :unrepute
    end
  end
  resources :knowledges do
    member do
      get :notes
      get :reviews
      get :my
    end
    collection do
      get :notes
    end
  end
  resources :resources
  root :to => "home#index"
end
