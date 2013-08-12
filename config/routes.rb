SocialStudy::Application.routes.draw do

  match "/search" => "search#index", :as => :search

  resources :reviews

  resources :reminds, only: [:index] do
    collection do
      get :short_index
    end
  end

  resources :comments, only: [:create, :destroy] do
    collection do
      get :paginate
    end
  end

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

  resources :experiences do
    member do
      post :reputed
    end
  end


  resources :microblogs
  resources :states, only: [:show, :destroy] do
    member do
      post :relay
    end
  end


  devise_for :users, :path => "account", :controllers => {
    :registrations => :account,
    :sessions => :sessions,
    :omniauth_callbacks => "users/omniauth_callbacks"
    } do
    get "account/update_private_token" => "account#update_private_token", :as => :update_private_token_account
  end

  resources :users, :only => [:show, :update] do
    member do
      post :follow
      post :unfollow
      get :following
      get :followers
      post :vote
      get :states
      get :describe
      get :cancel_describe
      put :update_describe
    end
  end
  resources :knowledges do
    member do
      get :notes
      get :experiences
      get :my
    end
    collection do
      get :top
      get :top_experiences
      get :top_notes
    end
  end

  resources :resources do
    collection do
      get :top
      get :top_experiences
      get :top_reviews
    end
  end

  root :to => "home#index"

  #mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
end
