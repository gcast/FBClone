FBClone::Application.routes.draw do
 
  resources :users, only: [:new, :create, :show] do
  	resources :friend_requests, only: [:create]
  	resources :posts, only: [:create, :index]
    resources :albums, only: [:create, :index, :destroy]

  	member do
  		get 'friends'
  		get 'about'
  	end

  end
  resource :session, only: [:new, :create, :destroy]
  resources :friendships, only: [:destroy]
  resources :albums, only: [:new, :show] do
    resources :photos, only: [:destroy]
  end
  

  # MAKE RESTFUL ??
  put "/friend_requests/:id/accept", { as: :accept_request, controller: :friend_requests, action: :accept }
  put "/friend_requests/:id/decline", { as: :decline_request, controller: :friend_requests, action: :decline }
  
  post "/posts/:post_id/comment", { as: :post_comment, controller: :comments, action: :create }
  post "/photos/:photo_id/comment", { as: :photo_comment, controller: :comments, action: :create }

  root to: 'users#new'

end


