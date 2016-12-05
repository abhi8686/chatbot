Rails.application.routes.draw do

  devise_for :users, skip: [:session], :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations"
  }

  as :user do 
    get "/login" => 'devise/sessions#new', as: :new_user_session
    post "/login" => 'devise/sessions#create', as: :user_session
    delete "/logout" => 'devise/sessions#destroy', as: :destroy_user_session
  end
   as :user do
    get '/register', to: 'devise/registrations#new', as: :register
    get '/login', to: 'devise/sessions#new', as: :login
    get '/logout', to: 'devise/sessions#destroy', as: :logout
  end

  resources :user_friendships do
    member do
      put :accept
    end
  end

  resources :users do
    member do
      get :following, :followers
      patch :state_facebook
      patch :state_twitter
    end
  end

resources :relationships, only: [:create, :destroy]

resources :statuses do
  member do
      put "like", to: "statuses#upvote"
      put "unlike", to: "statuses#downvote"
  end
  resources :comments
end

  resources :statuses
  get 'feeds', to: 'statuses#index', as: :feeds
  get "post_video", to: "statuses#create_post_video"

  resources :educational_details

  resources :a_brief_about_yourselves
  resources :work_experiences
  resources :notifications
  resources :messages

  root to: 'welcome#index'

  get '/:id', to: 'profiles#show', as: 'profile'
  get 'edit_profile/:id', to: 'profiles#edit', as: 'edit_profile'
  get 'profiles/users', to: 'profiles#index', as: :profiles_users

  resources :profiles do
    put :profile_params
  end

  resources :conversations do
    resources :messages
  end

  namespace :api do
    namespace :v1 do
      get '/:profile_name/interests', to: "interests#index"
    end
  end
  
end
