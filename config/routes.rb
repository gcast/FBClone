FBClone::Application.routes.draw do
  
  root to: 'users#new'

  resources :users, only: [:new, :create] do
  	resources :friend_requests, only: [:create]
  	resources :posts, only: [:create, :index]
    resources :albums, only: [:create, :index, :destroy]
    resources :message_threads, only: [:create]

  	member do
  		get 'friends'
  		get 'about'
      get 'wall'
      get 'newsfeed'
      get 'messages'
      get 'friend_message_thread'
  	end
  end

  resources :albums, only: [:new, :show, :edit, :update] do
    resources :photos, only: [:destroy]
  end

  resources :posts, only: [:show, :destroy] do
    member do 
      post 'like'
    end
  end

  resources :message_threads, only: [:show] do
    resources :messages, only: [:create]
  end

  resource :session, only: [:new, :create, :destroy]
  resources :friend_groups, only: [:new, :create, :index, :destroy]
  resources :friend_group_joins, only: [:destroy]
  resources :comments, only: [:destroy]
  resources :friendships, only: [:destroy]
  resources :notifications, only: [:index, :show]
  resources :online_friends, only: [:index]
  resources :likes, only: [:destroy]


  get "/search" => "pages#search"
  put "/friend_requests/:id/accept", { as: :accept_request, controller: :friend_requests, action: :accept }
  put "/friend_requests/:id/decline", { as: :decline_request, controller: :friend_requests, action: :decline }
  post "/posts/:post_id/comment", { as: :post_comment, controller: :comments, action: :create }
  post "/photos/:photo_id/comment", { as: :photo_comment, controller: :comments, action: :create }


  #ROUTES FOR BACKBONE

  namespace :api, :defaults => { :format => :json } do
    resources :message_threads
    resources :messages
    resources :users 
  end
  
end


