SocialStudy::Application.routes.draw do

  resources :entries, except: [:show, :create] do
    collection do
      get 'next/:title', action: 'next'
      get 'history'
    end
  end

  match "/search" => "search#index", :as => :search

  resources :reviews, except: [:index]
  resources :notes, except: [:index]
  resources :experiences, except: [:index]
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
      post :study
      post :grade
      post :collect
      get :states
      get :describe
      get :cancel_describe
      put :update_describe
      get :knowledges
      get :resources
      get :reviews
      get :notes
      get :experiences
    end
  end
  resources :knowledges, expect: :destroy do
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

  resources :resources, expect: :destroy do
    collection do
      get :top
      get :top_experiences
      get :top_reviews
    end
  end

  root :to => "states#index"

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
end
